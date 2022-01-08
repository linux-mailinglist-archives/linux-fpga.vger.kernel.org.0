Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74C8948811C
	for <lists+linux-fpga@lfdr.de>; Sat,  8 Jan 2022 04:35:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233304AbiAHDfg (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 7 Jan 2022 22:35:36 -0500
Received: from mga06.intel.com ([134.134.136.31]:9778 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229834AbiAHDfg (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 7 Jan 2022 22:35:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641612936; x=1673148936;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4OhFLWCrUroJF/xtAZxj6QcCWPNqdhlaQ2FqD1tIaMk=;
  b=XAMzUjkUS1oQezq4DGuOleYQT0TxGc0zgszmiLDnJEldyEgl6Qqj86oX
   K/IZ+vQbwIwtf4l0ZkPAMJHz6elnydlFc5rbC3T3CDqi8aJEO822uFsaM
   eIggwLO5CNTn9BZhE82XRus5AZq9f+eXmyBdDU1JgCe5XPffbOmd8z2wR
   4rRa2GZGiVf1Wq7n/cVj1jHYTj5y3efRudFfppj/S7YM4QbjR6+Hc1AA4
   Kw/BFwZjDOiU3DL7Vnj/7lr+KYkkOD+jXyymIGMhpOr/DxUQq8U7PjwYy
   Fbg9bu0nCbYohxM1clb2AwBKSbTjJSNkfWuITNhA4EZvMroq+f5aZcluc
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10220"; a="303725588"
X-IronPort-AV: E=Sophos;i="5.88,271,1635231600"; 
   d="scan'208";a="303725588"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 19:35:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,271,1635231600"; 
   d="scan'208";a="471508535"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 07 Jan 2022 19:35:32 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n62Vv-0000Dc-OL; Sat, 08 Jan 2022 03:35:31 +0000
Date:   Sat, 8 Jan 2022 11:34:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lizhi Hou <lizhi.hou@xilinx.com>, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Lizhi Hou <lizhi.hou@xilinx.com>,
        linux-fpga@vger.kernel.org, maxz@xilinx.com,
        sonal.santan@xilinx.com, yliu@xilinx.com, michal.simek@xilinx.com,
        stefanos@xilinx.com, devicetree@vger.kernel.org, trix@redhat.com
Subject: Re: [PATCH V4 XRT Alveo Infrastructure 3/5] of: create empty of root
Message-ID: <202201081100.CZieN1nu-lkp@intel.com>
References: <20220105225013.1567871-4-lizhi.hou@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220105225013.1567871-4-lizhi.hou@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Lizhi,

I love your patch! Perhaps something to improve:

[auto build test WARNING on robh/for-next]
[also build test WARNING on linux/master linus/master v5.16-rc8 next-20220107]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Lizhi-Hou/XRT-Alveo-driver-infrastructure-overview/20220106-065312
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: i386-randconfig-m021-20220105 (https://download.01.org/0day-ci/archive/20220108/202201081100.CZieN1nu-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

New smatch warnings:
drivers/of/fdt.c:541 of_fdt_root_init() warn: inconsistent indenting

Old smatch warnings:
drivers/of/fdt.c:1313 early_init_dt_add_memory_arch() warn: unsigned 'base + size' is never less than zero.
drivers/of/fdt.c:1318 early_init_dt_add_memory_arch() warn: unsigned 'base' is never less than zero.
drivers/of/fdt.c:1428 unflatten_and_copy_device_tree() warn: should '1 << (((__builtin_constant_p((((((7 * 4) + 4) + 4) + 4)) - 1)) ?((((((((7 * 4) + 4) + 4) + 4)) - 1) < 2) ?0:63 - __builtin_clzll((((((7 * 4) + 4) + 4) + 4)) - 1)):((4 <= 4)) ?__ilog2_u32((((((7 * 4) + 4) + 4) + 4)) - 1):__ilog2_u64((((((7 * 4) + 4) + 4) + 4)) - 1)) + 1)' be a 64 bit type?

vim +541 drivers/of/fdt.c

   468	
   469	static int __init of_fdt_root_init(void)
   470	{
   471		struct device_node *dt = NULL, *np;
   472		void *fdt = NULL, *fdt_aligned;
   473		struct property *prop = NULL;
   474		__be32 *val = NULL;
   475		int size, rc = 0;
   476	
   477	#if !defined(CONFIG_OF_UNITTEST)
   478		if (of_root)
   479			return 0;
   480	#endif
   481		size = __dtb_fdt_default_end - __dtb_fdt_default_begin;
   482	
   483		fdt = kmalloc(size + FDT_ALIGN_SIZE, GFP_KERNEL);
   484		if (!fdt)
   485			return -ENOMEM;
   486	
   487		fdt_aligned = PTR_ALIGN(fdt, FDT_ALIGN_SIZE);
   488		memcpy(fdt_aligned, __dtb_fdt_default_begin, size);
   489	
   490		if (!of_fdt_unflatten_tree((const unsigned long *)fdt_aligned,
   491					   NULL, &dt)) {
   492			pr_warn("%s: unflatten default tree failed\n", __func__);
   493			kfree(fdt);
   494			return -ENODATA;
   495		}
   496		if (!dt) {
   497			pr_warn("%s: empty default tree\n", __func__);
   498			kfree(fdt);
   499			return -ENODATA;
   500		}
   501	
   502		/*
   503		 * This lock normally encloses of_resolve_phandles()
   504		 */
   505		of_overlay_mutex_lock();
   506	
   507		rc = of_resolve_phandles(dt);
   508		if (rc) {
   509			pr_err("%s: Failed to resolve phandles (rc=%i)\n", __func__, rc);
   510			goto failed;
   511		}
   512	
   513		if (!of_root) {
   514			prop = kcalloc(2, sizeof(*prop), GFP_KERNEL);
   515			if (!prop) {
   516				rc = -ENOMEM;
   517				goto failed;
   518			}
   519			val = kzalloc(sizeof(*val), GFP_KERNEL);
   520			if (!val) {
   521				rc = -ENOMEM;
   522				goto failed;
   523			}
   524			*val = cpu_to_be32(sizeof(void *) / sizeof(u32));
   525	
   526			prop->name = "#address-cells";
   527			prop->value = val;
   528			prop->length = sizeof(u32);
   529			of_add_property(dt, prop);
   530			prop++;
   531			prop->name = "#size-cells";
   532			prop->value = val;
   533			prop->length = sizeof(u32);
   534			of_add_property(dt, prop);
   535			of_root = dt;
   536			for_each_of_allnodes(np)
   537				__of_attach_node_sysfs(np);
   538			of_aliases = of_find_node_by_path("/aliases");
   539			of_chosen = of_find_node_by_path("/chosen");
   540			of_overlay_mutex_unlock();
 > 541	pr_info("OF ROOT FLAG %lx\n", of_root->_flags);
   542			return 0;
   543		}
   544	
   545		unittest_data_add(dt);
   546	
   547		of_overlay_mutex_unlock();
   548	
   549		return 0;
   550	
   551	failed:
   552		of_overlay_mutex_unlock();
   553		kfree(val);
   554		kfree(prop);
   555		return rc;
   556	}
   557	pure_initcall(of_fdt_root_init);
   558	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
