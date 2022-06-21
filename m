Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1D1A5535E0
	for <lists+linux-fpga@lfdr.de>; Tue, 21 Jun 2022 17:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352752AbiFUPWK (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 21 Jun 2022 11:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352740AbiFUPWI (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 21 Jun 2022 11:22:08 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F2C828983;
        Tue, 21 Jun 2022 08:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655824927; x=1687360927;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1flX2RejbeqfiODphgVCmQ1ehxJD9lWgF0DaPcQBkuA=;
  b=DrDxz3VdRgZTH5birRPOto2LDFc6d2DuTt1ZkTZwrgLzdbdgT6TbYFgG
   5XOur2LS5J5TkYwwOnXzUJEek/rY7bg3orWR7TbHX5cbVWp3XiPD7vQyC
   368C3rcLfUUWpT6o0iyu+LmlqZ8lZ3QiETEd/hw8Z0Uoc9+R4svlasbd5
   i+goJe8zHmdgK0FIveIN9bOuUWmO8GRdIcEn85Th7N2gKqNPY75xg4aO0
   2kW93IN6TQe3CaqbqZcVYco1tkjtYlwwnRAKUOzW6zRB5TJXbu2C4/WJM
   KPezGlfwrdhrF3ArZplw4Lhj0UuNS8A7ozRu+v6y+7FmCKOLg0Jr55F9S
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10385"; a="305588892"
X-IronPort-AV: E=Sophos;i="5.92,209,1650956400"; 
   d="scan'208";a="305588892"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2022 08:22:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,209,1650956400"; 
   d="scan'208";a="585807080"
Received: from lkp-server02.sh.intel.com (HELO a67cc04a5eeb) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 21 Jun 2022 08:22:02 -0700
Received: from kbuild by a67cc04a5eeb with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o3fhZ-00004Z-LC;
        Tue, 21 Jun 2022 15:22:01 +0000
Date:   Tue, 21 Jun 2022 23:21:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nava kishore Manne <nava.manne@xilinx.com>,
        michal.simek@xilinx.com, hao.wu@intel.com, trix@redhat.com,
        mdf@kernel.org, yilun.xu@intel.com, gregkh@linuxfoundation.org,
        ronak.jain@xilinx.com, rajan.vaja@xilinx.com,
        abhyuday.godhasara@xilinx.com, piyush.mehta@xilinx.com,
        harsha.harsha@xilinx.com, lakshmi.sai.krishna.potthuri@xilinx.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org, git@xilinx.com
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org
Subject: Re: [PATCH v2 2/3] firmware: xilinx: Add pm api function for PL
 readback
Message-ID: <202206212247.2Ky8WLW2-lkp@intel.com>
References: <20220621092833.1057408-3-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220621092833.1057408-3-nava.manne@xilinx.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Nava,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v5.19-rc3 next-20220621]
[cannot apply to xilinx-xlnx/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Nava-kishore-Manne/fpga-manager-change-status-api-prototype-don-t-use-older/20220621-183524
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 78ca55889a549a9a194c6ec666836329b774ab6d
config: hexagon-randconfig-r003-20220620 (https://download.01.org/0day-ci/archive/20220621/202206212247.2Ky8WLW2-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project af6d2a0b6825e71965f3e2701a63c239fa0ad70f)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/6b66792a9e4acd718d58c0e5a33ca2426837be87
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Nava-kishore-Manne/fpga-manager-change-status-api-prototype-don-t-use-older/20220621-183524
        git checkout 6b66792a9e4acd718d58c0e5a33ca2426837be87
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/fpga/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from drivers/fpga/zynqmp-fpga.c:13:
>> include/linux/firmware/xlnx-zynqmp.h:747:1: error: expected identifier or '('
   {
   ^
   1 error generated.


vim +747 include/linux/firmware/xlnx-zynqmp.h

   743	
   744	static int zynqmp_pm_fpga_read(const u32 reg_numframes,
   745				       const phys_addr_t phys_address,
   746				       bool readback_type, u32 *value);
 > 747	{
   748		return -ENODEV;
   749	}
   750	#endif
   751	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
