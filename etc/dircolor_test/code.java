// dummy java code for colorscheme test
public List<List<Integer>> threeSum(int[] nums) {
        List<List<Integer>> result = new ArrayList<List<Integer>>();
        Arrays.sort(nums);
        for(int i = 0; i < nums.length-2; i++){
            if(i == 0 || (i > 0 && nums[i]!= nums[i-1])) {
                int low = i + 1;
                int high = nums.length - 1;
                while(low < high){
                    int curr = nums[i] + nums[low] + nums[high];
                    if(curr > 0){
                        high--;
                    }
                    else if(curr < 0){
                        low++;
                    }
                    else{
                        List<Integer> ans = new ArrayList<Integer>();
                        ans.add(nums[i]);
                        ans.add(nums[low]);
                        ans.add(nums[high]);
                        result.add(ans);
                        while(low < high && nums[high] == nums[high-1])high--;
                        while(low < high && nums[low] == nums[low+1])low++;
                        high--;
                        low++;
                    }
                }
            }
        }
        return result;
    }
