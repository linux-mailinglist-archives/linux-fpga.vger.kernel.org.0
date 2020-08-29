Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B728825645E
	for <lists+linux-fpga@lfdr.de>; Sat, 29 Aug 2020 05:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbgH2DaI (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 28 Aug 2020 23:30:08 -0400
Received: from mga04.intel.com ([192.55.52.120]:46101 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726452AbgH2DaI (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 28 Aug 2020 23:30:08 -0400
IronPort-SDR: yUfN54haXNcU2uv6OKEffEk82kUtqsNyObZ+oKI5AgG7AiWOJ/UXEPVVGY77cE/pVpwVCIapVY
 PNJxFC/N26SQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9727"; a="154184703"
X-IronPort-AV: E=Sophos;i="5.76,366,1592895600"; 
   d="scan'208";a="154184703"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2020 20:30:07 -0700
IronPort-SDR: /NaORErbG5OE7WGwIEjsHitI+XZaJ9ejrGEnp47v0lC+BpGYzF34ugosEg3SHBlzlKczy3dsf7
 bzbfa1szMDEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,366,1592895600"; 
   d="scan'208";a="300441888"
Received: from lkp-server02.sh.intel.com (HELO 301dc1beeb51) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 28 Aug 2020 20:30:05 -0700
Received: from kbuild by 301dc1beeb51 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kBrZ6-0000Ky-CV; Sat, 29 Aug 2020 03:30:04 +0000
Date:   Sat, 29 Aug 2020 11:30:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luca Ceresoli <luca@lucaceresoli.net>, linux-fpga@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Luca Ceresoli <luca@lucaceresoli.net>,
        Moritz Fischer <mdf@kernel.org>, Tom Rix <trix@redhat.com>,
        Michal Simek <monstr@monstr.eu>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH v3 4/5] fpga manager: xilinx-spi: add error checking
 after gpiod_get_value()
Message-ID: <202008291117.tPETSgId%lkp@intel.com>
References: <20200828195808.27975-4-luca@lucaceresoli.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200828195808.27975-4-luca@lucaceresoli.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Luca,

I love your patch! Perhaps something to improve:

[auto build test WARNING on v5.9-rc2]
[also build test WARNING on next-20200828]
[cannot apply to xlnx/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Luca-Ceresoli/fpga-manager-xilinx-spi-remove-stray-comment/20200829-040041
base:    d012a7190fc1fd72ed48911e77ca97ba4521bccd
compiler: nds32le-linux-gcc (GCC) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cppcheck warnings: (new ones prefixed by >>)

>> drivers/fpga/xilinx-spi.c:183:10: warning: Uninitialized variable: expired [uninitvar]
    while (!expired) {
            ^

# https://github.com/0day-ci/linux/commit/5ae295c0b82631de73665c58df85ec3ed8567a8e
git remote add linux-review https://github.com/0day-ci/linux
git fetch --no-tags linux-review Luca-Ceresoli/fpga-manager-xilinx-spi-remove-stray-comment/20200829-040041
git checkout 5ae295c0b82631de73665c58df85ec3ed8567a8e
vim +183 drivers/fpga/xilinx-spi.c

061c97d13f1a69 Anatolij Gustschin 2017-03-23  168  
061c97d13f1a69 Anatolij Gustschin 2017-03-23  169  static int xilinx_spi_write_complete(struct fpga_manager *mgr,
061c97d13f1a69 Anatolij Gustschin 2017-03-23  170  				     struct fpga_image_info *info)
061c97d13f1a69 Anatolij Gustschin 2017-03-23  171  {
061c97d13f1a69 Anatolij Gustschin 2017-03-23  172  	struct xilinx_spi_conf *conf = mgr->priv;
629463d1acc532 Luca Ceresoli      2020-08-28  173  	unsigned long timeout = jiffies + usecs_to_jiffies(info->config_complete_timeout_us);
629463d1acc532 Luca Ceresoli      2020-08-28  174  	bool expired;
629463d1acc532 Luca Ceresoli      2020-08-28  175  	int done;
061c97d13f1a69 Anatolij Gustschin 2017-03-23  176  	int ret;
061c97d13f1a69 Anatolij Gustschin 2017-03-23  177  
629463d1acc532 Luca Ceresoli      2020-08-28  178  	/*
629463d1acc532 Luca Ceresoli      2020-08-28  179  	 * This loop is carefully written such that if the driver is
629463d1acc532 Luca Ceresoli      2020-08-28  180  	 * scheduled out for more than 'timeout', we still check for DONE
629463d1acc532 Luca Ceresoli      2020-08-28  181  	 * before giving up and we apply 8 extra CCLK cycles in all cases.
629463d1acc532 Luca Ceresoli      2020-08-28  182  	 */
629463d1acc532 Luca Ceresoli      2020-08-28 @183  	while (!expired) {
629463d1acc532 Luca Ceresoli      2020-08-28  184  		expired = time_after(jiffies, timeout);
061c97d13f1a69 Anatolij Gustschin 2017-03-23  185  
629463d1acc532 Luca Ceresoli      2020-08-28  186  		done = get_done_gpio(mgr);
629463d1acc532 Luca Ceresoli      2020-08-28  187  		if (done < 0)
629463d1acc532 Luca Ceresoli      2020-08-28  188  			return done;
061c97d13f1a69 Anatolij Gustschin 2017-03-23  189  
061c97d13f1a69 Anatolij Gustschin 2017-03-23  190  		ret = xilinx_spi_apply_cclk_cycles(conf);
061c97d13f1a69 Anatolij Gustschin 2017-03-23  191  		if (ret)
061c97d13f1a69 Anatolij Gustschin 2017-03-23  192  			return ret;
061c97d13f1a69 Anatolij Gustschin 2017-03-23  193  
629463d1acc532 Luca Ceresoli      2020-08-28  194  		if (done)
629463d1acc532 Luca Ceresoli      2020-08-28  195  			return 0;
061c97d13f1a69 Anatolij Gustschin 2017-03-23  196  	}
061c97d13f1a69 Anatolij Gustschin 2017-03-23  197  
70cac0e8c9ec83 Luca Ceresoli      2020-08-28  198  	dev_err(&mgr->dev, "Timeout after config data transfer\n");
061c97d13f1a69 Anatolij Gustschin 2017-03-23  199  	return -ETIMEDOUT;
061c97d13f1a69 Anatolij Gustschin 2017-03-23  200  }
061c97d13f1a69 Anatolij Gustschin 2017-03-23  201  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
