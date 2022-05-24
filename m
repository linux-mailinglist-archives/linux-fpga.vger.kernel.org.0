Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4067F532AE4
	for <lists+linux-fpga@lfdr.de>; Tue, 24 May 2022 15:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235503AbiEXNLp (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 24 May 2022 09:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234363AbiEXNLo (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 24 May 2022 09:11:44 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8041D0EE;
        Tue, 24 May 2022 06:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653397899; x=1684933899;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SmN9eDUJ4qmT0MLcs7cK8b/8BBBtgaWpR9aaOC/E5u0=;
  b=n8aVLhDF228l2XBU0FwmRD5U6k2jMEPEMtKNKMB0EE7t6adJYLqSbgM+
   DTTaU8HanzFzAraULDSszBwwiSd5q0HKmlIYMtemCwwP/0qaZK89mRMTt
   a9vUunwbxRf680AvdWQLB37KUYUkJ1fIK/yoi0cpIjUYqRx7hJUul1Bed
   LMhXqAArNzAuNe14jAcXqPMFk+4+k+DV+F474TB1c1+Rqj3+nqb+LUFFH
   eV/n9eYGOr6x8Q3SM9sUIMU02/jA/guyKdaj/2X6E8dN5rOiPsplFQJiv
   Jc43aHLoXcrFqlTuCwWVv6qyG+CnGKc3Af/114CKHz6izNHvzz9D1QxBS
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10356"; a="272343607"
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; 
   d="scan'208";a="272343607"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 06:11:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; 
   d="scan'208";a="526397467"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 24 May 2022 06:11:34 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ntUJx-00024N-D7;
        Tue, 24 May 2022 13:11:33 +0000
Date:   Tue, 24 May 2022 21:10:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nava kishore Manne <nava.manne@xilinx.com>,
        michal.simek@xilinx.com, mdf@kernel.org, hao.wu@intel.com,
        yilun.xu@intel.com, trix@redhat.com, gregkh@linuxfoundation.org,
        ronak.jain@xilinx.com, abhyuday.godhasara@xilinx.com,
        rajan.vaja@xilinx.com, lakshmi.sai.krishna.potthuri@xilinx.com,
        piyush.mehta@xilinx.com, harsha.harsha@xilinx.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org, git@xilinx.com
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org
Subject: Re: [PATCH 2/3] firmware: xilinx: Add pm api function for PL readback
Message-ID: <202205242059.n4mNNqLG-lkp@intel.com>
References: <20220524094745.287002-3-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220524094745.287002-3-nava.manne@xilinx.com>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Nava,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on next-20220524]
[also build test ERROR on v5.18]
[cannot apply to xilinx-xlnx/master soc/for-next linus/master v5.18 v5.18-rc7 v5.18-rc6]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Nava-kishore-Manne/fpga-mgr-Update-the-status-for-fpga-manager/20220524-184838
base:    09ce5091ff971cdbfd67ad84dc561ea27f10d67a
config: hexagon-randconfig-r011-20220524 (https://download.01.org/0day-ci/archive/20220524/202205242059.n4mNNqLG-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 10c9ecce9f6096e18222a331c5e7d085bd813f75)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/cc20fc570e528f1bc378aa2e979e7e2ee7f52863
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Nava-kishore-Manne/fpga-mgr-Update-the-status-for-fpga-manager/20220524-184838
        git checkout cc20fc570e528f1bc378aa2e979e7e2ee7f52863
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/spi/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from drivers/spi/spi-zynqmp-gqspi.c:13:
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
