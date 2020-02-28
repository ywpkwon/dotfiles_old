import cv2
import tensorflow as tf

img = cv2.imread('/home/paul/projects/renesas-deep-learning/data/0000.png')
img = cv2.resize(img, (512, 288))
assert img is not None

cls_logits = ['ssd_multibox/block3_box/conv_cls/BatchNorm/FusedBatchNorm',
              'ssd_multibox/block4_box/conv_cls/BatchNorm/FusedBatchNorm',
              'ssd_multibox/block5_box/conv_cls/BatchNorm/FusedBatchNorm',
              'ssd_multibox/block11_box/conv_cls/BatchNorm/FusedBatchNorm']
loc_logits = ['ssd_multibox/block3_box/conv_loc/BatchNorm/FusedBatchNorm',
              'ssd_multibox/block4_box/conv_loc/BatchNorm/FusedBatchNorm',
              'ssd_multibox/block5_box/conv_loc/BatchNorm/FusedBatchNorm',
              'ssd_multibox/block11_box/conv_loc/BatchNorm/FusedBatchNorm']
seg_logits = 'seg_decode/upf/BiasAdd'

cls_logits = [t + ':0' for t in cls_logits]
loc_logits = [t + ':0' for t in loc_logits]
seg_logits += ':0'

pb_path = '/home/paul/projects/renesas-deep-learning/data/cfg_phantomlmdb_ssd_renesas_v4-max-mAP_logit.pb'


def load_graph(frozen_graph_filename):
    # We load the protobuf file from the disk and parse it to retrieve the
    # unserialized graph_def
    with tf.gfile.GFile(frozen_graph_filename, "rb") as f:
        graph_def = tf.GraphDef()
        graph_def.ParseFromString(f.read())

    # Then, we import the graph_def into a new Graph and returns it
    with tf.Graph().as_default() as graph:
        # The name var will prefix every op/nodes in your graph
        # Since we load everything in a new graph, this is not needed
        tf.import_graph_def(graph_def, name="")
    return graph


graph = load_graph(pb_path)

# X = tf.placeholder("float", [None, n_input])
# Y = tf.placeholder("float", [None, n_classes])
# input_node  = graph.get_tensor_by_name('prefix/Variable_quantized_const:0')
# output_node = graph.get_tensor_by_name('prefix/Mean_1:0')
# mnist = input_data.read_data_sets("/tmp/data/", one_hot=True)

config = tf.ConfigProto()
#config.gpu_options.per_process_gpu_memory_fraction = 0.4
config.gpu_options.allow_growth = True

with tf.Session(graph=graph, config=config) as sess:
    cls_logits, loc_logits, seg_logits = sess.run([cls_logits, loc_logits, seg_logits], feed_dict={'image:0': img[None, :, :, :]})

#     print("Accuracy:", output_node.eval({X: mnist.test.images, Y: mnist.test.labels})

# with tf.gfile.GFile(pb_path, "rb") as f:
#     graph_def = tf.GraphDef()
#     graph_def.ParseFromString(f.read())

#     with tf.Graph().as_default() as graph:
#         new_input = tf.placeholder(tf.float32, [1, 288, 512, 3], name="new_input")

#         tf.import_graph_def(
#             graph_def,
#             # usually, during training you use queues, but at inference time use placeholders
#             # this turns into "input
#             input_map={"image:0": new_input},
#             return_elements=None,
#             # if input_map is not None, needs a name
#             name="",
#             op_dict=None,
#             producer_op_list=None
#         )

#     checkpoint_path = tf.train.latest_checkpoint("./tmp/")

#     with tf.Session(graph=graph) as sess:
#         saver = tf.train.import_meta_graph(checkpoint_path + ".meta", import_scope=None)
#         saver.restore(sess, checkpoint_path)

#         output = sess.run("output:0", feed_dict={"input:0": np.arange(10, dtype=np.float32)})
#         print "output", output

