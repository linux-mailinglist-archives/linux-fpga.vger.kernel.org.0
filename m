Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 203B0532C69
	for <lists+linux-fpga@lfdr.de>; Tue, 24 May 2022 16:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238302AbiEXOmS (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 24 May 2022 10:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238217AbiEXOmR (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 24 May 2022 10:42:17 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF4706C575;
        Tue, 24 May 2022 07:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653403335; x=1684939335;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1wMFaExfNoxL0zAqrbdgIdhhubcuFqY9N2gbyIVbxYY=;
  b=jGF/jeOrJo8Mj5+jOnNn+gPJcVnOraTqP+2V1YYLrNkhIrDXmqtOTdiJ
   ueJAcFmqOvQKF6njE9foemACApQLKG1PBoBhn1g3Xx3eBvDSzQJAOxNyp
   jAH1CI8U6QVtcdndFfyx+uZqqJleTp7mRsNnSqoZAlbb/L22fKaGEezGp
   EoMxoGPxlEiSpoOTLuznUkO1bfvpnqMZBwWMlCd4/5zu1NwUlvxEIWwLF
   AuML96bDBU+1z02X2l8lTo1zODtFSrJywT3UHYtsyRwpE7tqLZXUX/E//
   BWOdKjD/ax55Vn4WS/oWYXxv37pWRBFfZrgZUEU1Qb5vB9FNVTAvKSjGR
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10357"; a="273544628"
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; 
   d="scan'208";a="273544628"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 07:42:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; 
   d="scan'208";a="559141662"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 24 May 2022 07:42:10 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ntVjd-000294-V2;
        Tue, 24 May 2022 14:42:09 +0000
Date:   Tue, 24 May 2022 22:41:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nava kishore Manne <nava.manne@xilinx.com>,
        michal.simek@xilinx.com, mdf@kernel.org, hao.wu@intel.com,
        yilun.xu@intel.com, trix@redhat.com, gregkh@linuxfoundation.org,
        ronak.jain@xilinx.com, abhyuday.godhasara@xilinx.com,
        rajan.vaja@xilinx.com, lakshmi.sai.krishna.potthuri@xilinx.com,
        piyush.mehta@xilinx.com, harsha.harsha@xilinx.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org, git@xilinx.com
Cc:     kbuild-all@lists.01.org
Subject: Re: [PATCH 2/3] firmware: xilinx: Add pm api function for PL readback
Message-ID: <202205242222.Rq35goGC-lkp@intel.com>
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
config: x86_64-randconfig-a013 (https://download.01.org/0day-ci/archive/20220524/202205242222.Rq35goGC-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/cc20fc570e528f1bc378aa2e979e7e2ee7f52863
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Nava-kishore-Manne/fpga-mgr-Update-the-status-for-fpga-manager/20220524-184838
        git checkout cc20fc570e528f1bc378aa2e979e7e2ee7f52863
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from drivers/spi/spi-zynqmp-gqspi.c:13:
>> include/linux/firmware/xlnx-zynqmp.h:747:1: error: expected identifier or '(' before '{' token
     747 | {
         | ^
   include/linux/firmware/xlnx-zynqmp.h:744:12: warning: 'zynqmp_pm_fpga_read' declared 'static' but never defined [-Wunused-function]
     744 | static int zynqmp_pm_fpga_read(const u32 reg_numframes,
         |            ^~~~~~~~~~~~~~~~~~~


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
