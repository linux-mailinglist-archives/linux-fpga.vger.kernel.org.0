Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E24D04B5CF6
	for <lists+linux-fpga@lfdr.de>; Mon, 14 Feb 2022 22:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbiBNVeg (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 14 Feb 2022 16:34:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231436AbiBNVdp (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 14 Feb 2022 16:33:45 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F0B6BC10;
        Mon, 14 Feb 2022 13:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644874292; x=1676410292;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nVcSprTXkhP3aqq6ijMMGA5otSVh37h8gNcsRTrYVdQ=;
  b=ZPDPQ1kS5QY8Fdfa9ihjxupQuW3pb0cOGRKw79sA2VUkCPC2icVLL9VZ
   nWyUj/Lw9ecuD2ZhP0wRu0FA8VZkePbfwmfY/zM0BFY73DNiHjxSFXQhg
   ZhPyHaJbrRzfiaSNLFWMLJmCWYhcSMFwAbN3s7kF+3/8eTFqgwv4bGtMP
   3gsaWIgxDQ4dtI/dePdXcTZMc3V7WJw7j1DP6tFTdADYeSxAJYNAEw5Yr
   76HTwwz1k/QIyku0gb3ZCGWkuxcQacbq7IWBRLWMdA3ZHJfd/PpVWaeLX
   amU7DkBaIbGfYzrAobjmLGGtXWmFYgJIYCHa8T49GU0QRqq7VPqXqI4hC
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="274738979"
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="274738979"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 11:23:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,368,1635231600"; 
   d="scan'208";a="495955011"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 14 Feb 2022 11:23:16 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nJgwN-0008rH-TT; Mon, 14 Feb 2022 19:23:15 +0000
Date:   Tue, 15 Feb 2022 03:22:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ivan Bornyakov <i.bornyakov@metrotek.ru>
Cc:     kbuild-all@lists.01.org, mdf@kernel.org, hao.wu@intel.com,
        yilun.xu@intel.com, trix@redhat.com, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org, system@metrotek.ru,
        Ivan Bornyakov <i.bornyakov@metrotek.ru>
Subject: Re: [PATCH] fpga: microsemi-spi: add Microsemi FPGA manager
Message-ID: <202202150337.lVXXx685-lkp@intel.com>
References: <20220214133835.25097-1-i.bornyakov@metrotek.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220214133835.25097-1-i.bornyakov@metrotek.ru>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Ivan,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v5.17-rc4 next-20220214]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Ivan-Bornyakov/fpga-microsemi-spi-add-Microsemi-FPGA-manager/20220214-222923
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 754e0b0e35608ed5206d6a67a791563c631cec07
config: h8300-allyesconfig (https://download.01.org/0day-ci/archive/20220215/202202150337.lVXXx685-lkp@intel.com/config)
compiler: h8300-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/19d9c174f03a9b8387ba654d558351cac9d63d24
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Ivan-Bornyakov/fpga-microsemi-spi-add-Microsemi-FPGA-manager/20220214-222923
        git checkout 19d9c174f03a9b8387ba654d558351cac9d63d24
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=h8300 SHELL=/bin/bash drivers/fpga/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/build_bug.h:5,
                    from include/linux/container_of.h:5,
                    from include/linux/list.h:5,
                    from include/linux/module.h:12,
                    from drivers/fpga/microsemi-spi.c:6:
   include/linux/scatterlist.h: In function 'sg_set_buf':
   include/asm-generic/page.h:89:51: warning: ordered comparison of pointer with null pointer [-Wextra]
      89 | #define virt_addr_valid(kaddr)  (((void *)(kaddr) >= (void *)PAGE_OFFSET) && \
         |                                                   ^~
   include/linux/compiler.h:78:45: note: in definition of macro 'unlikely'
      78 | # define unlikely(x)    __builtin_expect(!!(x), 0)
         |                                             ^
   include/linux/scatterlist.h:160:9: note: in expansion of macro 'BUG_ON'
     160 |         BUG_ON(!virt_addr_valid(buf));
         |         ^~~~~~
   include/linux/scatterlist.h:160:17: note: in expansion of macro 'virt_addr_valid'
     160 |         BUG_ON(!virt_addr_valid(buf));
         |                 ^~~~~~~~~~~~~~~
   In file included from include/linux/device.h:15,
                    from include/linux/spi/spi.h:10,
                    from drivers/fpga/microsemi-spi.c:7:
   drivers/fpga/microsemi-spi.c: In function 'microsemi_fpga_ops_write':
   drivers/fpga/microsemi-spi.c:244:30: warning: format '%d' expects argument of type 'int', but argument 3 has type 'ssize_t' {aka 'long int'} [-Wformat=]
     244 |                 dev_err(dev, "Failed to find bitstream start %d\n",
         |                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:144:56: note: in expansion of macro 'dev_fmt'
     144 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                        ^~~~~~~
   drivers/fpga/microsemi-spi.c:244:17: note: in expansion of macro 'dev_err'
     244 |                 dev_err(dev, "Failed to find bitstream start %d\n",
         |                 ^~~~~~~
   drivers/fpga/microsemi-spi.c:244:63: note: format string is defined here
     244 |                 dev_err(dev, "Failed to find bitstream start %d\n",
         |                                                              ~^
         |                                                               |
         |                                                               int
         |                                                              %ld
   In file included from include/linux/device.h:15,
                    from include/linux/spi/spi.h:10,
                    from drivers/fpga/microsemi-spi.c:7:
   drivers/fpga/microsemi-spi.c:252:30: warning: format '%d' expects argument of type 'int', but argument 3 has type 'ssize_t' {aka 'long int'} [-Wformat=]
     252 |                 dev_err(dev, "Failed to parse bitstream size %d\n",
         |                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:144:56: note: in expansion of macro 'dev_fmt'
     144 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                        ^~~~~~~
   drivers/fpga/microsemi-spi.c:252:17: note: in expansion of macro 'dev_err'
     252 |                 dev_err(dev, "Failed to parse bitstream size %d\n",
         |                 ^~~~~~~
   drivers/fpga/microsemi-spi.c:252:63: note: format string is defined here
     252 |                 dev_err(dev, "Failed to parse bitstream size %d\n",
         |                                                              ~^
         |                                                               |
         |                                                               int
         |                                                              %ld
   In file included from include/linux/device.h:15,
                    from include/linux/spi/spi.h:10,
                    from drivers/fpga/microsemi-spi.c:7:
   drivers/fpga/microsemi-spi.c:260:25: warning: format '%d' expects argument of type 'int', but argument 3 has type 'ssize_t' {aka 'long int'} [-Wformat=]
     260 |                         "Bitstram outruns firmware. Bitstream start %d, bitstream size %d, firmware size %d\n",
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:144:56: note: in expansion of macro 'dev_fmt'
     144 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                        ^~~~~~~
   drivers/fpga/microsemi-spi.c:259:17: note: in expansion of macro 'dev_err'
     259 |                 dev_err(dev,
         |                 ^~~~~~~
   drivers/fpga/microsemi-spi.c:260:70: note: format string is defined here
     260 |                         "Bitstram outruns firmware. Bitstream start %d, bitstream size %d, firmware size %d\n",
         |                                                                     ~^
         |                                                                      |
         |                                                                      int
         |                                                                     %ld
   In file included from include/linux/device.h:15,
                    from include/linux/spi/spi.h:10,
                    from drivers/fpga/microsemi-spi.c:7:
>> drivers/fpga/microsemi-spi.c:260:25: warning: format '%d' expects argument of type 'int', but argument 4 has type 'long int' [-Wformat=]
     260 |                         "Bitstram outruns firmware. Bitstream start %d, bitstream size %d, firmware size %d\n",
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:144:56: note: in expansion of macro 'dev_fmt'
     144 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                        ^~~~~~~
   drivers/fpga/microsemi-spi.c:259:17: note: in expansion of macro 'dev_err'
     259 |                 dev_err(dev,
         |                 ^~~~~~~
   drivers/fpga/microsemi-spi.c:260:89: note: format string is defined here
     260 |                         "Bitstram outruns firmware. Bitstream start %d, bitstream size %d, firmware size %d\n",
         |                                                                                        ~^
         |                                                                                         |
         |                                                                                         int
         |                                                                                        %ld
   In file included from include/linux/device.h:15,
                    from include/linux/spi/spi.h:10,
                    from drivers/fpga/microsemi-spi.c:7:
   drivers/fpga/microsemi-spi.c:260:25: warning: format '%d' expects argument of type 'int', but argument 5 has type 'size_t' {aka 'long unsigned int'} [-Wformat=]
     260 |                         "Bitstram outruns firmware. Bitstream start %d, bitstream size %d, firmware size %d\n",
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:144:56: note: in expansion of macro 'dev_fmt'
     144 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                        ^~~~~~~
   drivers/fpga/microsemi-spi.c:259:17: note: in expansion of macro 'dev_err'
     259 |                 dev_err(dev,
         |                 ^~~~~~~
   drivers/fpga/microsemi-spi.c:260:107: note: format string is defined here
     260 |                         "Bitstram outruns firmware. Bitstream start %d, bitstream size %d, firmware size %d\n",
         |                                                                                                          ~^
         |                                                                                                           |
         |                                                                                                           int
         |                                                                                                          %ld
   In file included from include/linux/device.h:15,
                    from include/linux/spi/spi.h:10,
                    from drivers/fpga/microsemi-spi.c:7:
   drivers/fpga/microsemi-spi.c:274:33: warning: format '%d' expects argument of type 'int', but argument 4 has type 'ssize_t' {aka 'long int'} [-Wformat=]
     274 |                                 "Failed to write bitstream frame number %d of %d\n",
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:144:56: note: in expansion of macro 'dev_fmt'
     144 |         dev_printk_index_wrap(_dev_err, KERN_ERR, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                        ^~~~~~~
   drivers/fpga/microsemi-spi.c:273:25: note: in expansion of macro 'dev_err'
     273 |                         dev_err(dev,
         |                         ^~~~~~~
   drivers/fpga/microsemi-spi.c:274:80: note: format string is defined here
     274 |                                 "Failed to write bitstream frame number %d of %d\n",
         |                                                                               ~^
         |                                                                                |
         |                                                                                int
         |                                                                               %ld


vim +260 drivers/fpga/microsemi-spi.c

   225	
   226	static int microsemi_fpga_ops_write(struct fpga_manager *mgr, const char *buf,
   227					    size_t count)
   228	{
   229		ssize_t bitstream_start = 0, bitstream_size;
   230		struct microsemi_fpga_priv *priv = mgr->priv;
   231		struct spi_device *spi = priv->spi;
   232		struct device *dev = &mgr->dev;
   233		u8 tmp_buf[SPI_FRAME_SIZE + 1];
   234		int ret, i;
   235	
   236		if (crc_ccitt(0, buf, count)) {
   237			dev_err(dev, "CRC error\n");
   238	
   239			return -EINVAL;
   240		}
   241	
   242		bitstream_start = lookup_block_start(BITSTREAM_ID, buf, count);
   243		if (bitstream_start < 0) {
   244			dev_err(dev, "Failed to find bitstream start %d\n",
   245				bitstream_start);
   246	
   247			return bitstream_start;
   248		}
   249	
   250		bitstream_size = parse_bitstream_size(buf, count);
   251		if (bitstream_size < 0) {
   252			dev_err(dev, "Failed to parse bitstream size %d\n",
   253				bitstream_size);
   254	
   255			return bitstream_size;
   256		}
   257	
   258		if (bitstream_start + bitstream_size * SPI_FRAME_SIZE > count) {
   259			dev_err(dev,
 > 260				"Bitstram outruns firmware. Bitstream start %d, bitstream size %d, firmware size %d\n",
   261				bitstream_start, bitstream_size * SPI_FRAME_SIZE, count);
   262	
   263			return -EFAULT;
   264		}
   265	
   266		for (i = 0; i < bitstream_size; i++) {
   267			tmp_buf[0] = SPI_FRAME;
   268			memcpy(tmp_buf + 1, buf + bitstream_start + i * SPI_FRAME_SIZE,
   269			       SPI_FRAME_SIZE);
   270	
   271			ret = microsemi_spi_write(spi, tmp_buf, sizeof(tmp_buf));
   272			if (ret) {
   273				dev_err(dev,
   274					"Failed to write bitstream frame number %d of %d\n",
   275					i, bitstream_size);
   276	
   277				return ret;
   278			}
   279		}
   280	
   281		return 0;
   282	}
   283	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
