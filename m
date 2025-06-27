Return-Path: <linux-fpga+bounces-1255-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA0CAEB3C1
	for <lists+linux-fpga@lfdr.de>; Fri, 27 Jun 2025 12:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AD1A3ADAC8
	for <lists+linux-fpga@lfdr.de>; Fri, 27 Jun 2025 10:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC3F296155;
	Fri, 27 Jun 2025 10:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dnl2p/3W"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EA514A82;
	Fri, 27 Jun 2025 10:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751018806; cv=none; b=RnPE55tePpWSRLZ3n++AvLlXt0enkycJbdWRfkvZvJIOAvZJomKGJFIFjB42V7l9DBVB8JBazg/EnBAArwuT5xHPjVlS45oNDvYFlOXDDApGd9DxrcEc2yV8qJ5j+4lk1E+72srGni5ougsmEgqEvLdqP3QtLCriTbA2FZHahJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751018806; c=relaxed/simple;
	bh=fFvzkvZn0bd2VOmS1GX3tRdsOr2lpN9Cu344yzpEDcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pGnXNxFDazVVXJpSPBR0T81rn8lk0qe1EQzOXBSmHaH+OcZVN3pg9eiaaegRRrFQDYlQ4joA8RJJYK8BYitNw83PYVufouIpi44IgaMwp7HEWQCTe5a+gU715AbU5cjmKu87gakA3KH89zkbvJwH6gSDlKKQ0VbdWcsLyhmHTn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dnl2p/3W; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751018804; x=1782554804;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fFvzkvZn0bd2VOmS1GX3tRdsOr2lpN9Cu344yzpEDcY=;
  b=Dnl2p/3WcR+OGeGatg9kT2A3Duvk7fW8aiaYnIDe0C7q4GQ18d41M3LO
   +Yo6cn69qnim5qiOEVlzbB3opOxGiHQGrtQN2KSGqe/uWHKJ29CV4qwiT
   nUbSlciKCmXi9T0Ywc4byS5s1VD57zsXOAe1wCwpG2ENOgvWHBZhbHN2O
   Xf/RmMas0manYRThd0m48UiQZTGht1h1GDkKiiaXgyPTi6TKkDwhUrGtK
   odGq+xaDxjSHjaB41mdfn9lUv3VVusfxi5hn/dDSre3bRle34P3jT067G
   fzy/zbsmV1lVXDM6BB8UtUg0sZ2lN6ibirrXYtANNQgYyIajZoksdPske
   w==;
X-CSE-ConnectionGUID: sZ44wPE+TfWccksXNza/ug==
X-CSE-MsgGUID: QgBUEjdkR7aL4WbjnhBYgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11476"; a="53426425"
X-IronPort-AV: E=Sophos;i="6.16,270,1744095600"; 
   d="scan'208";a="53426425"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2025 03:06:44 -0700
X-CSE-ConnectionGUID: ZukoQkmRTSy9ssUnn59tcw==
X-CSE-MsgGUID: bVCMUO8tQGmNUpGo6cPWvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,270,1744095600"; 
   d="scan'208";a="189962410"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 27 Jun 2025 03:06:42 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uV5yh-000W34-1K;
	Fri, 27 Jun 2025 10:06:39 +0000
Date: Fri, 27 Jun 2025 18:06:17 +0800
From: kernel test robot <lkp@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Xu Yilun <yilun.xu@intel.com>, linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Moritz Fischer <mdf@kernel.org>,
	Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>
Subject: Re: [PATCH v1 1/1] fpga: altera-cvp: Use pci_find_vsec_capability()
 when probing FPGA device
Message-ID: <202506271724.dQ1jAckC-lkp@intel.com>
References: <20250627061431.522016-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250627061431.522016-1-andriy.shevchenko@linux.intel.com>

Hi Andy,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.16-rc3 next-20250626]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/fpga-altera-cvp-Use-pci_find_vsec_capability-when-probing-FPGA-device/20250627-142050
base:   linus/master
patch link:    https://lore.kernel.org/r/20250627061431.522016-1-andriy.shevchenko%40linux.intel.com
patch subject: [PATCH v1 1/1] fpga: altera-cvp: Use pci_find_vsec_capability() when probing FPGA device
config: i386-buildonly-randconfig-001-20250627 (https://download.01.org/0day-ci/archive/20250627/202506271724.dQ1jAckC-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14+deb12u1) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250627/202506271724.dQ1jAckC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506271724.dQ1jAckC-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/fpga/altera-cvp.c: In function 'altera_cvp_probe':
>> drivers/fpga/altera-cvp.c:577:18: warning: unused variable 'val' [-Wunused-variable]
     577 |         u16 cmd, val;
         |                  ^~~


vim +/val +577 drivers/fpga/altera-cvp.c

34d1dc17ce978a Anatolij Gustschin 2017-06-14  571  
34d1dc17ce978a Anatolij Gustschin 2017-06-14  572  static int altera_cvp_probe(struct pci_dev *pdev,
34d1dc17ce978a Anatolij Gustschin 2017-06-14  573  			    const struct pci_device_id *dev_id)
34d1dc17ce978a Anatolij Gustschin 2017-06-14  574  {
34d1dc17ce978a Anatolij Gustschin 2017-06-14  575  	struct altera_cvp_conf *conf;
7085e2a94f7df5 Alan Tull          2018-05-16  576  	struct fpga_manager *mgr;
34d1dc17ce978a Anatolij Gustschin 2017-06-14 @577  	u16 cmd, val;
823fd4b4a8bd1f Andy Shevchenko    2025-06-27  578  	u16 offset;
68f60538daa4bc Andreas Puhm       2018-11-07  579  	u32 regval;
823fd4b4a8bd1f Andy Shevchenko    2025-06-27  580  	int ret;
34d1dc17ce978a Anatolij Gustschin 2017-06-14  581  
34d1dc17ce978a Anatolij Gustschin 2017-06-14  582  	/*
34d1dc17ce978a Anatolij Gustschin 2017-06-14  583  	 * First check if this is the expected FPGA device. PCI config
34d1dc17ce978a Anatolij Gustschin 2017-06-14  584  	 * space access works without enabling the PCI device, memory
34d1dc17ce978a Anatolij Gustschin 2017-06-14  585  	 * space access is enabled further down.
34d1dc17ce978a Anatolij Gustschin 2017-06-14  586  	 */
823fd4b4a8bd1f Andy Shevchenko    2025-06-27  587  	offset = pci_find_vsec_capability(pdev, PCI_VENDOR_ID_ALTERA, 0);
823fd4b4a8bd1f Andy Shevchenko    2025-06-27  588  	if (!offset) {
823fd4b4a8bd1f Andy Shevchenko    2025-06-27  589  		dev_err(&pdev->dev, "Wrong EXT_CAP_ID value\n");
34d1dc17ce978a Anatolij Gustschin 2017-06-14  590  		return -ENODEV;
34d1dc17ce978a Anatolij Gustschin 2017-06-14  591  	}
34d1dc17ce978a Anatolij Gustschin 2017-06-14  592  
eb12511f0d47b4 Thor Thayer        2019-08-19  593  	pci_read_config_dword(pdev, offset + VSE_CVP_STATUS, &regval);
68f60538daa4bc Andreas Puhm       2018-11-07  594  	if (!(regval & VSE_CVP_STATUS_CVP_EN)) {
68f60538daa4bc Andreas Puhm       2018-11-07  595  		dev_err(&pdev->dev,
68f60538daa4bc Andreas Puhm       2018-11-07  596  			"CVP is disabled for this device: CVP_STATUS Reg 0x%x\n",
68f60538daa4bc Andreas Puhm       2018-11-07  597  			regval);
68f60538daa4bc Andreas Puhm       2018-11-07  598  		return -ENODEV;
68f60538daa4bc Andreas Puhm       2018-11-07  599  	}
68f60538daa4bc Andreas Puhm       2018-11-07  600  
34d1dc17ce978a Anatolij Gustschin 2017-06-14  601  	conf = devm_kzalloc(&pdev->dev, sizeof(*conf), GFP_KERNEL);
34d1dc17ce978a Anatolij Gustschin 2017-06-14  602  	if (!conf)
34d1dc17ce978a Anatolij Gustschin 2017-06-14  603  		return -ENOMEM;
34d1dc17ce978a Anatolij Gustschin 2017-06-14  604  
eb12511f0d47b4 Thor Thayer        2019-08-19  605  	conf->vsec_offset = offset;
eb12511f0d47b4 Thor Thayer        2019-08-19  606  
34d1dc17ce978a Anatolij Gustschin 2017-06-14  607  	/*
34d1dc17ce978a Anatolij Gustschin 2017-06-14  608  	 * Enable memory BAR access. We cannot use pci_enable_device() here
34d1dc17ce978a Anatolij Gustschin 2017-06-14  609  	 * because it will make the driver unusable with FPGA devices that
34d1dc17ce978a Anatolij Gustschin 2017-06-14  610  	 * have additional big IOMEM resources (e.g. 4GiB BARs) on 32-bit
34d1dc17ce978a Anatolij Gustschin 2017-06-14  611  	 * platform. Such BARs will not have an assigned address range and
34d1dc17ce978a Anatolij Gustschin 2017-06-14  612  	 * pci_enable_device() will fail, complaining about not claimed BAR,
34d1dc17ce978a Anatolij Gustschin 2017-06-14  613  	 * even if the concerned BAR is not needed for FPGA configuration
34d1dc17ce978a Anatolij Gustschin 2017-06-14  614  	 * at all. Thus, enable the device via PCI config space command.
34d1dc17ce978a Anatolij Gustschin 2017-06-14  615  	 */
34d1dc17ce978a Anatolij Gustschin 2017-06-14  616  	pci_read_config_word(pdev, PCI_COMMAND, &cmd);
34d1dc17ce978a Anatolij Gustschin 2017-06-14  617  	if (!(cmd & PCI_COMMAND_MEMORY)) {
34d1dc17ce978a Anatolij Gustschin 2017-06-14  618  		cmd |= PCI_COMMAND_MEMORY;
34d1dc17ce978a Anatolij Gustschin 2017-06-14  619  		pci_write_config_word(pdev, PCI_COMMAND, cmd);
34d1dc17ce978a Anatolij Gustschin 2017-06-14  620  	}
34d1dc17ce978a Anatolij Gustschin 2017-06-14  621  
34d1dc17ce978a Anatolij Gustschin 2017-06-14  622  	ret = pci_request_region(pdev, CVP_BAR, "CVP");
34d1dc17ce978a Anatolij Gustschin 2017-06-14  623  	if (ret) {
34d1dc17ce978a Anatolij Gustschin 2017-06-14  624  		dev_err(&pdev->dev, "Requesting CVP BAR region failed\n");
34d1dc17ce978a Anatolij Gustschin 2017-06-14  625  		goto err_disable;
34d1dc17ce978a Anatolij Gustschin 2017-06-14  626  	}
34d1dc17ce978a Anatolij Gustschin 2017-06-14  627  
34d1dc17ce978a Anatolij Gustschin 2017-06-14  628  	conf->pci_dev = pdev;
34d1dc17ce978a Anatolij Gustschin 2017-06-14  629  	conf->write_data = altera_cvp_write_data_iomem;
34d1dc17ce978a Anatolij Gustschin 2017-06-14  630  
e58915179f3f4a Thor Thayer        2019-08-19  631  	if (conf->vsec_offset == V1_VSEC_OFFSET)
e58915179f3f4a Thor Thayer        2019-08-19  632  		conf->priv = &cvp_priv_v1;
e58915179f3f4a Thor Thayer        2019-08-19  633  	else
e58915179f3f4a Thor Thayer        2019-08-19  634  		conf->priv = &cvp_priv_v2;
e58915179f3f4a Thor Thayer        2019-08-19  635  
34d1dc17ce978a Anatolij Gustschin 2017-06-14  636  	conf->map = pci_iomap(pdev, CVP_BAR, 0);
34d1dc17ce978a Anatolij Gustschin 2017-06-14  637  	if (!conf->map) {
34d1dc17ce978a Anatolij Gustschin 2017-06-14  638  		dev_warn(&pdev->dev, "Mapping CVP BAR failed\n");
34d1dc17ce978a Anatolij Gustschin 2017-06-14  639  		conf->write_data = altera_cvp_write_data_config;
34d1dc17ce978a Anatolij Gustschin 2017-06-14  640  	}
34d1dc17ce978a Anatolij Gustschin 2017-06-14  641  
34d1dc17ce978a Anatolij Gustschin 2017-06-14  642  	snprintf(conf->mgr_name, sizeof(conf->mgr_name), "%s @%s",
34d1dc17ce978a Anatolij Gustschin 2017-06-14  643  		 ALTERA_CVP_MGR_NAME, pci_name(pdev));
34d1dc17ce978a Anatolij Gustschin 2017-06-14  644  
4ba0b2c294fe69 Russ Weight        2021-11-18  645  	mgr = fpga_mgr_register(&pdev->dev, conf->mgr_name,
34d1dc17ce978a Anatolij Gustschin 2017-06-14  646  				&altera_cvp_ops, conf);
4ba0b2c294fe69 Russ Weight        2021-11-18  647  	if (IS_ERR(mgr)) {
4ba0b2c294fe69 Russ Weight        2021-11-18  648  		ret = PTR_ERR(mgr);
122c5770cff2c1 Christophe Jaillet 2018-06-27  649  		goto err_unmap;
122c5770cff2c1 Christophe Jaillet 2018-06-27  650  	}
7085e2a94f7df5 Alan Tull          2018-05-16  651  
7085e2a94f7df5 Alan Tull          2018-05-16  652  	pci_set_drvdata(pdev, mgr);
7085e2a94f7df5 Alan Tull          2018-05-16  653  
34d1dc17ce978a Anatolij Gustschin 2017-06-14  654  	return 0;
34d1dc17ce978a Anatolij Gustschin 2017-06-14  655  
34d1dc17ce978a Anatolij Gustschin 2017-06-14  656  err_unmap:
187fade88ca0ff Anatolij Gustschin 2018-11-07  657  	if (conf->map)
34d1dc17ce978a Anatolij Gustschin 2017-06-14  658  		pci_iounmap(pdev, conf->map);
34d1dc17ce978a Anatolij Gustschin 2017-06-14  659  	pci_release_region(pdev, CVP_BAR);
34d1dc17ce978a Anatolij Gustschin 2017-06-14  660  err_disable:
34d1dc17ce978a Anatolij Gustschin 2017-06-14  661  	cmd &= ~PCI_COMMAND_MEMORY;
34d1dc17ce978a Anatolij Gustschin 2017-06-14  662  	pci_write_config_word(pdev, PCI_COMMAND, cmd);
34d1dc17ce978a Anatolij Gustschin 2017-06-14  663  	return ret;
34d1dc17ce978a Anatolij Gustschin 2017-06-14  664  }
34d1dc17ce978a Anatolij Gustschin 2017-06-14  665  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

