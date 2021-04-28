Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42F7E36D0CD
	for <lists+linux-fpga@lfdr.de>; Wed, 28 Apr 2021 05:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235553AbhD1DNg (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 27 Apr 2021 23:13:36 -0400
Received: from mga06.intel.com ([134.134.136.31]:50306 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234429AbhD1DNg (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 27 Apr 2021 23:13:36 -0400
IronPort-SDR: SSfFQgNYsAmz1n0Qm0Ox2BDMJ62uNW/eH/Xfte7TshbhlpqSTwzI1Pii+7wROFUGfKSiCQZMFF
 dI0UIGHwKrMw==
X-IronPort-AV: E=McAfee;i="6200,9189,9967"; a="257945874"
X-IronPort-AV: E=Sophos;i="5.82,257,1613462400"; 
   d="gz'50?scan'50,208,50";a="257945874"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2021 20:12:50 -0700
IronPort-SDR: tv16q9vm+/K7X+zXQr8yxaElPZggwRoDQjlgDuHWgRkckuJ1Xz1fI7xOo7lTZOqDFJw9bGJFCF
 jb/de52NCyyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,257,1613462400"; 
   d="gz'50?scan'50,208,50";a="604733588"
Received: from lkp-server01.sh.intel.com (HELO a48ff7ddd223) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 27 Apr 2021 20:12:45 -0700
Received: from kbuild by a48ff7ddd223 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lbad3-0006uN-87; Wed, 28 Apr 2021 03:12:45 +0000
Date:   Wed, 28 Apr 2021 11:12:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lizhi Hou <lizhi.hou@xilinx.com>, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Lizhi Hou <lizhi.hou@xilinx.com>,
        linux-fpga@vger.kernel.org, maxz@xilinx.com,
        sonal.santan@xilinx.com, yliu@xilinx.com, michal.simek@xilinx.com,
        stefanos@xilinx.com, devicetree@vger.kernel.org, trix@redhat.com
Subject: Re: [PATCH V5 XRT Alveo 20/20] fpga: xrt: Kconfig and Makefile
 updates for XRT drivers
Message-ID: <202104281021.cmJBYG3S-lkp@intel.com>
References: <20210427205431.23896-21-lizhi.hou@xilinx.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="uAKRQypu60I7Lcqm"
Content-Disposition: inline
In-Reply-To: <20210427205431.23896-21-lizhi.hou@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Lizhi,

I love your patch! Perhaps something to improve:

[auto build test WARNING on linux/master]
[also build test WARNING on linus/master v5.12 next-20210427]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Lizhi-Hou/XRT-Alveo-driver-overview/20210428-050424
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 1fe5501ba1abf2b7e78295df73675423bd6899a0
config: x86_64-randconfig-s032-20210428 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.3-341-g8af24329-dirty
        # https://github.com/0day-ci/linux/commit/079fb263b22e0d961ac204b3928bdff5d8ebf3d5
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Lizhi-Hou/XRT-Alveo-driver-overview/20210428-050424
        git checkout 079fb263b22e0d961ac204b3928bdff5d8ebf3d5
        # save the attached .config to linux build tree
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' W=1 ARCH=x86_64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/fpga/xrt/lib/xclbin.c:314:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] freq @@     got restricted __be16 [usertype] @@
   drivers/fpga/xrt/lib/xclbin.c:314:22: sparse:     expected unsigned short [usertype] freq
   drivers/fpga/xrt/lib/xclbin.c:314:22: sparse:     got restricted __be16 [usertype]
--
>> drivers/fpga/xrt/lib/xleaf/vsec.c:270:9: sparse: sparse: cast to restricted __be32
>> drivers/fpga/xrt/lib/xleaf/vsec.c:270:9: sparse: sparse: cast to restricted __be32
>> drivers/fpga/xrt/lib/xleaf/vsec.c:270:9: sparse: sparse: cast to restricted __be32
>> drivers/fpga/xrt/lib/xleaf/vsec.c:270:9: sparse: sparse: cast to restricted __be32
>> drivers/fpga/xrt/lib/xleaf/vsec.c:270:9: sparse: sparse: cast to restricted __be32
>> drivers/fpga/xrt/lib/xleaf/vsec.c:270:9: sparse: sparse: cast to restricted __be32
>> drivers/fpga/xrt/lib/xleaf/vsec.c:270:9: sparse: sparse: cast to restricted __be64
>> drivers/fpga/xrt/lib/xleaf/vsec.c:270:9: sparse: sparse: cast to restricted __be64
>> drivers/fpga/xrt/lib/xleaf/vsec.c:270:9: sparse: sparse: cast to restricted __be64
>> drivers/fpga/xrt/lib/xleaf/vsec.c:270:9: sparse: sparse: cast to restricted __be64
>> drivers/fpga/xrt/lib/xleaf/vsec.c:270:9: sparse: sparse: cast to restricted __be64
>> drivers/fpga/xrt/lib/xleaf/vsec.c:270:9: sparse: sparse: cast to restricted __be64
>> drivers/fpga/xrt/lib/xleaf/vsec.c:270:9: sparse: sparse: cast to restricted __be64
>> drivers/fpga/xrt/lib/xleaf/vsec.c:270:9: sparse: sparse: cast to restricted __be64
>> drivers/fpga/xrt/lib/xleaf/vsec.c:270:9: sparse: sparse: cast to restricted __be64
>> drivers/fpga/xrt/lib/xleaf/vsec.c:270:9: sparse: sparse: cast to restricted __be64
   drivers/fpga/xrt/lib/xleaf/vsec.c:273:40: sparse: sparse: cast to restricted __be32
   drivers/fpga/xrt/lib/xleaf/vsec.c:273:40: sparse: sparse: cast to restricted __be32
   drivers/fpga/xrt/lib/xleaf/vsec.c:273:40: sparse: sparse: cast to restricted __be32
   drivers/fpga/xrt/lib/xleaf/vsec.c:273:40: sparse: sparse: cast to restricted __be32
   drivers/fpga/xrt/lib/xleaf/vsec.c:273:40: sparse: sparse: cast to restricted __be32
   drivers/fpga/xrt/lib/xleaf/vsec.c:273:40: sparse: sparse: cast to restricted __be32
   drivers/fpga/xrt/lib/xleaf/vsec.c:279:29: sparse: sparse: cast to restricted __be64
   drivers/fpga/xrt/lib/xleaf/vsec.c:279:29: sparse: sparse: cast to restricted __be64
   drivers/fpga/xrt/lib/xleaf/vsec.c:279:29: sparse: sparse: cast to restricted __be64
   drivers/fpga/xrt/lib/xleaf/vsec.c:279:29: sparse: sparse: cast to restricted __be64
   drivers/fpga/xrt/lib/xleaf/vsec.c:279:29: sparse: sparse: cast to restricted __be64
   drivers/fpga/xrt/lib/xleaf/vsec.c:279:29: sparse: sparse: cast to restricted __be64
   drivers/fpga/xrt/lib/xleaf/vsec.c:279:29: sparse: sparse: cast to restricted __be64
   drivers/fpga/xrt/lib/xleaf/vsec.c:279:29: sparse: sparse: cast to restricted __be64
   drivers/fpga/xrt/lib/xleaf/vsec.c:279:29: sparse: sparse: cast to restricted __be64
   drivers/fpga/xrt/lib/xleaf/vsec.c:279:29: sparse: sparse: cast to restricted __be64
--
>> drivers/fpga/xrt/lib/xleaf/icap.c:58:9: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned int @@     got restricted __be32 [usertype] @@
   drivers/fpga/xrt/lib/xleaf/icap.c:58:9: sparse:     expected unsigned int
   drivers/fpga/xrt/lib/xleaf/icap.c:58:9: sparse:     got restricted __be32 [usertype]
   drivers/fpga/xrt/lib/xleaf/icap.c:60:9: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned int @@     got restricted __be32 [usertype] @@
   drivers/fpga/xrt/lib/xleaf/icap.c:60:9: sparse:     expected unsigned int
   drivers/fpga/xrt/lib/xleaf/icap.c:60:9: sparse:     got restricted __be32 [usertype]
   drivers/fpga/xrt/lib/xleaf/icap.c:62:9: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned int @@     got restricted __be32 [usertype] @@
   drivers/fpga/xrt/lib/xleaf/icap.c:62:9: sparse:     expected unsigned int
   drivers/fpga/xrt/lib/xleaf/icap.c:62:9: sparse:     got restricted __be32 [usertype]
   drivers/fpga/xrt/lib/xleaf/icap.c:64:9: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned int @@     got restricted __be32 [usertype] @@
   drivers/fpga/xrt/lib/xleaf/icap.c:64:9: sparse:     expected unsigned int
   drivers/fpga/xrt/lib/xleaf/icap.c:64:9: sparse:     got restricted __be32 [usertype]
   drivers/fpga/xrt/lib/xleaf/icap.c:66:9: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned int @@     got restricted __be32 [usertype] @@
   drivers/fpga/xrt/lib/xleaf/icap.c:66:9: sparse:     expected unsigned int
   drivers/fpga/xrt/lib/xleaf/icap.c:66:9: sparse:     got restricted __be32 [usertype]
   drivers/fpga/xrt/lib/xleaf/icap.c:68:9: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned int @@     got restricted __be32 [usertype] @@
   drivers/fpga/xrt/lib/xleaf/icap.c:68:9: sparse:     expected unsigned int
   drivers/fpga/xrt/lib/xleaf/icap.c:68:9: sparse:     got restricted __be32 [usertype]
   drivers/fpga/xrt/lib/xleaf/icap.c:70:9: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned int @@     got restricted __be32 [usertype] @@
   drivers/fpga/xrt/lib/xleaf/icap.c:70:9: sparse:     expected unsigned int
   drivers/fpga/xrt/lib/xleaf/icap.c:70:9: sparse:     got restricted __be32 [usertype]
>> drivers/fpga/xrt/lib/xleaf/icap.c:113:25: sparse: sparse: cast to restricted __be32
>> drivers/fpga/xrt/lib/xleaf/icap.c:113:25: sparse: sparse: cast to restricted __be32
>> drivers/fpga/xrt/lib/xleaf/icap.c:113:25: sparse: sparse: cast to restricted __be32
>> drivers/fpga/xrt/lib/xleaf/icap.c:113:25: sparse: sparse: cast to restricted __be32
>> drivers/fpga/xrt/lib/xleaf/icap.c:113:25: sparse: sparse: cast to restricted __be32
>> drivers/fpga/xrt/lib/xleaf/icap.c:113:25: sparse: sparse: cast to restricted __be32
--
>> drivers/fpga/xrt/lib/xleaf/clock.c:506:31: sparse: sparse: cast to restricted __be16
>> drivers/fpga/xrt/lib/xleaf/clock.c:506:31: sparse: sparse: cast to restricted __be16
>> drivers/fpga/xrt/lib/xleaf/clock.c:506:31: sparse: sparse: cast to restricted __be16
>> drivers/fpga/xrt/lib/xleaf/clock.c:506:31: sparse: sparse: cast to restricted __be16
--
>> drivers/fpga/xrt/lib/subdev.c:195:33: sparse: sparse: cast to restricted __be32
>> drivers/fpga/xrt/lib/subdev.c:195:33: sparse: sparse: cast to restricted __be32
>> drivers/fpga/xrt/lib/subdev.c:195:33: sparse: sparse: cast to restricted __be32
>> drivers/fpga/xrt/lib/subdev.c:195:33: sparse: sparse: cast to restricted __be32
>> drivers/fpga/xrt/lib/subdev.c:195:33: sparse: sparse: cast to restricted __be32
>> drivers/fpga/xrt/lib/subdev.c:195:33: sparse: sparse: cast to restricted __be32
>> drivers/fpga/xrt/lib/subdev.c:197:57: sparse: sparse: cast to restricted __be64
>> drivers/fpga/xrt/lib/subdev.c:197:57: sparse: sparse: cast to restricted __be64
>> drivers/fpga/xrt/lib/subdev.c:197:57: sparse: sparse: cast to restricted __be64
>> drivers/fpga/xrt/lib/subdev.c:197:57: sparse: sparse: cast to restricted __be64
>> drivers/fpga/xrt/lib/subdev.c:197:57: sparse: sparse: cast to restricted __be64
>> drivers/fpga/xrt/lib/subdev.c:197:57: sparse: sparse: cast to restricted __be64
>> drivers/fpga/xrt/lib/subdev.c:197:57: sparse: sparse: cast to restricted __be64
>> drivers/fpga/xrt/lib/subdev.c:197:57: sparse: sparse: cast to restricted __be64
>> drivers/fpga/xrt/lib/subdev.c:197:57: sparse: sparse: cast to restricted __be64
>> drivers/fpga/xrt/lib/subdev.c:197:57: sparse: sparse: cast to restricted __be64
   drivers/fpga/xrt/lib/subdev.c:198:55: sparse: sparse: cast to restricted __be64
   drivers/fpga/xrt/lib/subdev.c:198:55: sparse: sparse: cast to restricted __be64
   drivers/fpga/xrt/lib/subdev.c:198:55: sparse: sparse: cast to restricted __be64
   drivers/fpga/xrt/lib/subdev.c:198:55: sparse: sparse: cast to restricted __be64
   drivers/fpga/xrt/lib/subdev.c:198:55: sparse: sparse: cast to restricted __be64
   drivers/fpga/xrt/lib/subdev.c:198:55: sparse: sparse: cast to restricted __be64
   drivers/fpga/xrt/lib/subdev.c:198:55: sparse: sparse: cast to restricted __be64
   drivers/fpga/xrt/lib/subdev.c:198:55: sparse: sparse: cast to restricted __be64
   drivers/fpga/xrt/lib/subdev.c:198:55: sparse: sparse: cast to restricted __be64
   drivers/fpga/xrt/lib/subdev.c:198:55: sparse: sparse: cast to restricted __be64
   drivers/fpga/xrt/lib/subdev.c:199:25: sparse: sparse: cast to restricted __be64
   drivers/fpga/xrt/lib/subdev.c:199:25: sparse: sparse: cast to restricted __be64
   drivers/fpga/xrt/lib/subdev.c:199:25: sparse: sparse: cast to restricted __be64
   drivers/fpga/xrt/lib/subdev.c:199:25: sparse: sparse: cast to restricted __be64
   drivers/fpga/xrt/lib/subdev.c:199:25: sparse: sparse: cast to restricted __be64
   drivers/fpga/xrt/lib/subdev.c:199:25: sparse: sparse: cast to restricted __be64
   drivers/fpga/xrt/lib/subdev.c:199:25: sparse: sparse: cast to restricted __be64
   drivers/fpga/xrt/lib/subdev.c:199:25: sparse: sparse: cast to restricted __be64
   drivers/fpga/xrt/lib/subdev.c:199:25: sparse: sparse: cast to restricted __be64
   drivers/fpga/xrt/lib/subdev.c:199:25: sparse: sparse: cast to restricted __be64
--
>> drivers/fpga/xrt/metadata/metadata.c:311:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] val @@     got restricted __be32 [usertype] @@
   drivers/fpga/xrt/metadata/metadata.c:311:21: sparse:     expected unsigned int [usertype] val
   drivers/fpga/xrt/metadata/metadata.c:311:21: sparse:     got restricted __be32 [usertype]
>> drivers/fpga/xrt/metadata/metadata.c:319:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long @@     got restricted __be64 [usertype] @@
   drivers/fpga/xrt/metadata/metadata.c:319:29: sparse:     expected unsigned long long
   drivers/fpga/xrt/metadata/metadata.c:319:29: sparse:     got restricted __be64 [usertype]
   drivers/fpga/xrt/metadata/metadata.c:320:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long @@     got restricted __be64 [usertype] @@
   drivers/fpga/xrt/metadata/metadata.c:320:29: sparse:     expected unsigned long long
   drivers/fpga/xrt/metadata/metadata.c:320:29: sparse:     got restricted __be64 [usertype]
--
>> drivers/fpga/xrt/mgnt/xmgnt-main-region.c:71:30: sparse: sparse: symbol 'xmgnt_bridge_ops' was not declared. Should it be static?
--
>> drivers/fpga/xrt/mgnt/root.c:211:18: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] vsec_bar @@     got restricted __be32 [usertype] @@
   drivers/fpga/xrt/mgnt/root.c:211:18: sparse:     expected unsigned int [usertype] vsec_bar
   drivers/fpga/xrt/mgnt/root.c:211:18: sparse:     got restricted __be32 [usertype]
>> drivers/fpga/xrt/mgnt/root.c:219:18: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] vsec_off @@     got restricted __be64 [usertype] @@
   drivers/fpga/xrt/mgnt/root.c:219:18: sparse:     expected unsigned long long [usertype] vsec_off
   drivers/fpga/xrt/mgnt/root.c:219:18: sparse:     got restricted __be64 [usertype]
--
>> drivers/fpga/xrt/mgnt/xmgnt-main.c:570:56: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got struct axlf *[addressable] xclbin @@
   drivers/fpga/xrt/mgnt/xmgnt-main.c:570:56: sparse:     expected void const [noderef] __user *from
   drivers/fpga/xrt/mgnt/xmgnt-main.c:570:56: sparse:     got struct axlf *[addressable] xclbin
   drivers/fpga/xrt/mgnt/xmgnt-main.c:585:48: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got struct axlf *[addressable] xclbin @@
   drivers/fpga/xrt/mgnt/xmgnt-main.c:585:48: sparse:     expected void const [noderef] __user *from
   drivers/fpga/xrt/mgnt/xmgnt-main.c:585:48: sparse:     got struct axlf *[addressable] xclbin

Please review and possibly fold the followup patch.

vim +314 drivers/fpga/xrt/lib/xclbin.c

d174deaba7ea5f Lizhi Hou 2021-04-27  243  
d174deaba7ea5f Lizhi Hou 2021-04-27  244  struct xrt_clock_desc {
d174deaba7ea5f Lizhi Hou 2021-04-27  245  	char	*clock_ep_name;
d174deaba7ea5f Lizhi Hou 2021-04-27  246  	u32	clock_xclbin_type;
d174deaba7ea5f Lizhi Hou 2021-04-27  247  	char	*clkfreq_ep_name;
d174deaba7ea5f Lizhi Hou 2021-04-27 @248  } clock_desc[] = {
d174deaba7ea5f Lizhi Hou 2021-04-27  249  	{
d174deaba7ea5f Lizhi Hou 2021-04-27  250  		.clock_ep_name = XRT_MD_NODE_CLK_KERNEL1,
d174deaba7ea5f Lizhi Hou 2021-04-27  251  		.clock_xclbin_type = CT_DATA,
d174deaba7ea5f Lizhi Hou 2021-04-27  252  		.clkfreq_ep_name = XRT_MD_NODE_CLKFREQ_K1,
d174deaba7ea5f Lizhi Hou 2021-04-27  253  	},
d174deaba7ea5f Lizhi Hou 2021-04-27  254  	{
d174deaba7ea5f Lizhi Hou 2021-04-27  255  		.clock_ep_name = XRT_MD_NODE_CLK_KERNEL2,
d174deaba7ea5f Lizhi Hou 2021-04-27  256  		.clock_xclbin_type = CT_KERNEL,
d174deaba7ea5f Lizhi Hou 2021-04-27  257  		.clkfreq_ep_name = XRT_MD_NODE_CLKFREQ_K2,
d174deaba7ea5f Lizhi Hou 2021-04-27  258  	},
d174deaba7ea5f Lizhi Hou 2021-04-27  259  	{
d174deaba7ea5f Lizhi Hou 2021-04-27  260  		.clock_ep_name = XRT_MD_NODE_CLK_KERNEL3,
d174deaba7ea5f Lizhi Hou 2021-04-27  261  		.clock_xclbin_type = CT_SYSTEM,
d174deaba7ea5f Lizhi Hou 2021-04-27  262  		.clkfreq_ep_name = XRT_MD_NODE_CLKFREQ_HBM,
d174deaba7ea5f Lizhi Hou 2021-04-27  263  	},
d174deaba7ea5f Lizhi Hou 2021-04-27  264  };
d174deaba7ea5f Lizhi Hou 2021-04-27  265  
d174deaba7ea5f Lizhi Hou 2021-04-27  266  const char *xrt_clock_type2epname(enum XCLBIN_CLOCK_TYPE type)
d174deaba7ea5f Lizhi Hou 2021-04-27  267  {
d174deaba7ea5f Lizhi Hou 2021-04-27  268  	int i;
d174deaba7ea5f Lizhi Hou 2021-04-27  269  
d174deaba7ea5f Lizhi Hou 2021-04-27  270  	for (i = 0; i < ARRAY_SIZE(clock_desc); i++) {
d174deaba7ea5f Lizhi Hou 2021-04-27  271  		if (clock_desc[i].clock_xclbin_type == type)
d174deaba7ea5f Lizhi Hou 2021-04-27  272  			return clock_desc[i].clock_ep_name;
d174deaba7ea5f Lizhi Hou 2021-04-27  273  	}
d174deaba7ea5f Lizhi Hou 2021-04-27  274  	return NULL;
d174deaba7ea5f Lizhi Hou 2021-04-27  275  }
d174deaba7ea5f Lizhi Hou 2021-04-27  276  EXPORT_SYMBOL_GPL(xrt_clock_type2epname);
d174deaba7ea5f Lizhi Hou 2021-04-27  277  
d174deaba7ea5f Lizhi Hou 2021-04-27  278  static const char *clock_type2clkfreq_name(enum XCLBIN_CLOCK_TYPE type)
d174deaba7ea5f Lizhi Hou 2021-04-27  279  {
d174deaba7ea5f Lizhi Hou 2021-04-27  280  	int i;
d174deaba7ea5f Lizhi Hou 2021-04-27  281  
d174deaba7ea5f Lizhi Hou 2021-04-27  282  	for (i = 0; i < ARRAY_SIZE(clock_desc); i++) {
d174deaba7ea5f Lizhi Hou 2021-04-27  283  		if (clock_desc[i].clock_xclbin_type == type)
d174deaba7ea5f Lizhi Hou 2021-04-27  284  			return clock_desc[i].clkfreq_ep_name;
d174deaba7ea5f Lizhi Hou 2021-04-27  285  	}
d174deaba7ea5f Lizhi Hou 2021-04-27  286  	return NULL;
d174deaba7ea5f Lizhi Hou 2021-04-27  287  }
d174deaba7ea5f Lizhi Hou 2021-04-27  288  
d174deaba7ea5f Lizhi Hou 2021-04-27  289  static int xrt_xclbin_add_clock_metadata(struct device *dev,
d174deaba7ea5f Lizhi Hou 2021-04-27  290  					 const struct axlf *xclbin,
d174deaba7ea5f Lizhi Hou 2021-04-27  291  					 char *dtb)
d174deaba7ea5f Lizhi Hou 2021-04-27  292  {
d174deaba7ea5f Lizhi Hou 2021-04-27  293  	struct clock_freq_topology *clock_topo;
d174deaba7ea5f Lizhi Hou 2021-04-27  294  	u16 freq;
d174deaba7ea5f Lizhi Hou 2021-04-27  295  	int rc;
d174deaba7ea5f Lizhi Hou 2021-04-27  296  	int i;
d174deaba7ea5f Lizhi Hou 2021-04-27  297  
d174deaba7ea5f Lizhi Hou 2021-04-27  298  	/* if clock section does not exist, add nothing and return success */
d174deaba7ea5f Lizhi Hou 2021-04-27  299  	rc = xrt_xclbin_get_section(dev, xclbin, CLOCK_FREQ_TOPOLOGY,
d174deaba7ea5f Lizhi Hou 2021-04-27  300  				    (void **)&clock_topo, NULL);
d174deaba7ea5f Lizhi Hou 2021-04-27  301  	if (rc == -ENOENT)
d174deaba7ea5f Lizhi Hou 2021-04-27  302  		return 0;
d174deaba7ea5f Lizhi Hou 2021-04-27  303  	else if (rc)
d174deaba7ea5f Lizhi Hou 2021-04-27  304  		return rc;
d174deaba7ea5f Lizhi Hou 2021-04-27  305  
d174deaba7ea5f Lizhi Hou 2021-04-27  306  	for (i = 0; i < clock_topo->count; i++) {
d174deaba7ea5f Lizhi Hou 2021-04-27  307  		u8 type = clock_topo->clock_freq[i].type;
d174deaba7ea5f Lizhi Hou 2021-04-27  308  		const char *ep_name = xrt_clock_type2epname(type);
d174deaba7ea5f Lizhi Hou 2021-04-27  309  		const char *counter_name = clock_type2clkfreq_name(type);
d174deaba7ea5f Lizhi Hou 2021-04-27  310  
d174deaba7ea5f Lizhi Hou 2021-04-27  311  		if (!ep_name || !counter_name)
d174deaba7ea5f Lizhi Hou 2021-04-27  312  			continue;
d174deaba7ea5f Lizhi Hou 2021-04-27  313  
d174deaba7ea5f Lizhi Hou 2021-04-27 @314  		freq = cpu_to_be16(clock_topo->clock_freq[i].freq_MHZ);
d174deaba7ea5f Lizhi Hou 2021-04-27  315  		rc = xrt_md_set_prop(dev, dtb, ep_name, NULL, XRT_MD_PROP_CLK_FREQ,
d174deaba7ea5f Lizhi Hou 2021-04-27  316  				     &freq, sizeof(freq));
d174deaba7ea5f Lizhi Hou 2021-04-27  317  		if (rc)
d174deaba7ea5f Lizhi Hou 2021-04-27  318  			break;
d174deaba7ea5f Lizhi Hou 2021-04-27  319  
d174deaba7ea5f Lizhi Hou 2021-04-27  320  		rc = xrt_md_set_prop(dev, dtb, ep_name, NULL, XRT_MD_PROP_CLK_CNT,
d174deaba7ea5f Lizhi Hou 2021-04-27  321  				     counter_name, strlen(counter_name) + 1);
d174deaba7ea5f Lizhi Hou 2021-04-27  322  		if (rc)
d174deaba7ea5f Lizhi Hou 2021-04-27  323  			break;
d174deaba7ea5f Lizhi Hou 2021-04-27  324  	}
d174deaba7ea5f Lizhi Hou 2021-04-27  325  
d174deaba7ea5f Lizhi Hou 2021-04-27  326  	vfree(clock_topo);
d174deaba7ea5f Lizhi Hou 2021-04-27  327  
d174deaba7ea5f Lizhi Hou 2021-04-27  328  	return rc;
d174deaba7ea5f Lizhi Hou 2021-04-27  329  }
d174deaba7ea5f Lizhi Hou 2021-04-27  330  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--uAKRQypu60I7Lcqm
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
gcqr4fPNdbA4s+2j6X8BkNv9NhJUAgA=

--uAKRQypu60I7Lcqm--
