Return-Path: <linux-fpga+bounces-1416-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE07C34B90
	for <lists+linux-fpga@lfdr.de>; Wed, 05 Nov 2025 10:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4331C34C1E4
	for <lists+linux-fpga@lfdr.de>; Wed,  5 Nov 2025 09:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488E92FB978;
	Wed,  5 Nov 2025 09:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aPZG6BRr"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BA12FD7CF;
	Wed,  5 Nov 2025 09:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762334083; cv=none; b=J6by31d3ToBr+09Cl03OkbSZZZvV8rg1RxJnglcasODaWIoegMaGcNMLeMBr8F4EM7HR3BURSZQ6QFPDmed/2zY8/iOwWexejXX2UidNhH7MR1D85pEnVes/2CLLrJ3Gswa22yLIRUR6vrsUmwodnUnmH+PRDHL9ZTGZxt4lxjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762334083; c=relaxed/simple;
	bh=RSHsbeFdKhC8QvY9ApXm+WcOtBpu6BQxsCPQZgDqEhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oH4b7VUrxNv5pzrfxQTEP/tW63sizCAxyZ6MnlQfArBMiUxYV0nL3iikk79rmyPholqnMZANWskG2V+dNq0xkQv3y9DYI2ynjUqJsv4qvcb3i+MvdXv4YLGmRDM8J/TRpP2EphM6BG0tifKJAD5UPtgNY1Q99rr9maRdpvRMTzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aPZG6BRr; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762334079; x=1793870079;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RSHsbeFdKhC8QvY9ApXm+WcOtBpu6BQxsCPQZgDqEhY=;
  b=aPZG6BRrtxOkU/ghtJXWPfbZJITDxRW8G3BebAazwNCfUSny83e1cbmA
   Vu6ymSo6RnajZ6SPkyNU8KUGGwB9aH++kjizEz0MnNj/ijIDNEaHzZ6I0
   bagTw9JJucPKFgKRIvJpu+mv4bWzZaPRoxUJncj/r8ZTiVpzZnX2FZASY
   5EeSth47kYM7jdMGsPS0fF0XMXK9BUr/mhQLHfTp7DjWfghQ7/cgPTIbX
   OxkmfBT+4RMjWMeouJ3imk4KNpqBtqC7lIq2Q6BbNZXs4mUMVqZWpuUqG
   z75qdhVhCKkUq7UF6t736/WvomkJ1us6UH1l1XqqXh0vqp2UMIAHkxwgS
   A==;
X-CSE-ConnectionGUID: 2Zgkeb6BSzq+TTMm7GWknQ==
X-CSE-MsgGUID: WBSVypItT42lgk0X6XzrIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="63450992"
X-IronPort-AV: E=Sophos;i="6.19,281,1754982000"; 
   d="scan'208";a="63450992"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 01:14:38 -0800
X-CSE-ConnectionGUID: or3Ko7iPQ8KDAiX8KKlOPQ==
X-CSE-MsgGUID: 0ClDQbJVRTuSh7f5aYa58g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,281,1754982000"; 
   d="scan'208";a="187562652"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 05 Nov 2025 01:14:37 -0800
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vGZb8-000SLw-0b;
	Wed, 05 Nov 2025 09:14:34 +0000
Date: Wed, 5 Nov 2025 17:13:03 +0800
From: kernel test robot <lkp@intel.com>
To: Ian Abbott <abbotti@mev.co.uk>, linux-fpga@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
	linux-kernel@vger.kernel.org, Ian Abbott <abbotti@mev.co.uk>
Subject: Re: [PATCH 2/4] fpga: bridge: Add dummy definitions of API functions
Message-ID: <202511051756.m53LZeZi-lkp@intel.com>
References: <20251104153013.154463-3-abbotti@mev.co.uk>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104153013.154463-3-abbotti@mev.co.uk>

Hi Ian,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.18-rc4 next-20251105]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ian-Abbott/fpga-altera-pr-ip-Add-dummy-definitions-of-API-functions/20251105-000956
base:   linus/master
patch link:    https://lore.kernel.org/r/20251104153013.154463-3-abbotti%40mev.co.uk
patch subject: [PATCH 2/4] fpga: bridge: Add dummy definitions of API functions
config: parisc-randconfig-001-20251105 (https://download.01.org/0day-ci/archive/20251105/202511051756.m53LZeZi-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 12.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251105/202511051756.m53LZeZi-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202511051756.m53LZeZi-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/fpga/fpga-bridge.c:29:5: error: redefinition of 'fpga_bridge_enable'
      29 | int fpga_bridge_enable(struct fpga_bridge *bridge)
         |     ^~~~~~~~~~~~~~~~~~
   In file included from drivers/fpga/fpga-bridge.c:8:
   include/linux/fpga/fpga-bridge.h:112:19: note: previous definition of 'fpga_bridge_enable' with type 'int(struct fpga_bridge *)'
     112 | static inline int fpga_bridge_enable(struct fpga_bridge *bridge)
         |                   ^~~~~~~~~~~~~~~~~~
>> drivers/fpga/fpga-bridge.c:47:5: error: redefinition of 'fpga_bridge_disable'
      47 | int fpga_bridge_disable(struct fpga_bridge *bridge)
         |     ^~~~~~~~~~~~~~~~~~~
   include/linux/fpga/fpga-bridge.h:117:19: note: previous definition of 'fpga_bridge_disable' with type 'int(struct fpga_bridge *)'
     117 | static inline int fpga_bridge_disable(struct fpga_bridge *bridge)
         |                   ^~~~~~~~~~~~~~~~~~~
>> drivers/fpga/fpga-bridge.c:91:21: error: redefinition of 'of_fpga_bridge_get'
      91 | struct fpga_bridge *of_fpga_bridge_get(struct device_node *np,
         |                     ^~~~~~~~~~~~~~~~~~
   include/linux/fpga/fpga-bridge.h:97:1: note: previous definition of 'of_fpga_bridge_get' with type 'struct fpga_bridge *(struct device_node *, struct fpga_image_info *)'
      97 | of_fpga_bridge_get(struct device_node *node, struct fpga_image_info *info)
         | ^~~~~~~~~~~~~~~~~~
>> drivers/fpga/fpga-bridge.c:123:21: error: redefinition of 'fpga_bridge_get'
     123 | struct fpga_bridge *fpga_bridge_get(struct device *dev,
         |                     ^~~~~~~~~~~~~~~
   include/linux/fpga/fpga-bridge.h:103:1: note: previous definition of 'fpga_bridge_get' with type 'struct fpga_bridge *(struct device *, struct fpga_image_info *)'
     103 | fpga_bridge_get(struct device *dev, struct fpga_image_info *info)
         | ^~~~~~~~~~~~~~~
>> drivers/fpga/fpga-bridge.c:147:6: error: redefinition of 'fpga_bridge_put'
     147 | void fpga_bridge_put(struct fpga_bridge *bridge)
         |      ^~~~~~~~~~~~~~~
   include/linux/fpga/fpga-bridge.h:108:20: note: previous definition of 'fpga_bridge_put' with type 'void(struct fpga_bridge *)'
     108 | static inline void fpga_bridge_put(struct fpga_bridge *bridge)
         |                    ^~~~~~~~~~~~~~~
>> drivers/fpga/fpga-bridge.c:166:5: error: redefinition of 'fpga_bridges_enable'
     166 | int fpga_bridges_enable(struct list_head *bridge_list)
         |     ^~~~~~~~~~~~~~~~~~~
   include/linux/fpga/fpga-bridge.h:122:19: note: previous definition of 'fpga_bridges_enable' with type 'int(struct list_head *)'
     122 | static inline int fpga_bridges_enable(struct list_head *bridge_list)
         |                   ^~~~~~~~~~~~~~~~~~~
>> drivers/fpga/fpga-bridge.c:190:5: error: redefinition of 'fpga_bridges_disable'
     190 | int fpga_bridges_disable(struct list_head *bridge_list)
         |     ^~~~~~~~~~~~~~~~~~~~
   include/linux/fpga/fpga-bridge.h:127:19: note: previous definition of 'fpga_bridges_disable' with type 'int(struct list_head *)'
     127 | static inline int fpga_bridges_disable(struct list_head *bridge_list)
         |                   ^~~~~~~~~~~~~~~~~~~~
>> drivers/fpga/fpga-bridge.c:213:6: error: redefinition of 'fpga_bridges_put'
     213 | void fpga_bridges_put(struct list_head *bridge_list)
         |      ^~~~~~~~~~~~~~~~
   include/linux/fpga/fpga-bridge.h:132:20: note: previous definition of 'fpga_bridges_put' with type 'void(struct list_head *)'
     132 | static inline void fpga_bridges_put(struct list_head *bridge_list)
         |                    ^~~~~~~~~~~~~~~~
>> drivers/fpga/fpga-bridge.c:239:5: error: redefinition of 'of_fpga_bridge_get_to_list'
     239 | int of_fpga_bridge_get_to_list(struct device_node *np,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/fpga/fpga-bridge.h:143:19: note: previous definition of 'of_fpga_bridge_get_to_list' with type 'int(struct device_node *, struct fpga_image_info *, struct list_head *)'
     143 | static inline int of_fpga_bridge_get_to_list(struct device_node *np,
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/fpga/fpga-bridge.c:269:5: error: redefinition of 'fpga_bridge_get_to_list'
     269 | int fpga_bridge_get_to_list(struct device *dev,
         |     ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/fpga/fpga-bridge.h:136:19: note: previous definition of 'fpga_bridge_get_to_list' with type 'int(struct device *, struct fpga_image_info *, struct list_head *)'
     136 | static inline int fpga_bridge_get_to_list(struct device *dev,
         |                   ^~~~~~~~~~~~~~~~~~~~~~~
>> drivers/fpga/fpga-bridge.c:332:1: error: redefinition of '__fpga_bridge_register'
     332 | __fpga_bridge_register(struct device *parent, const char *name,
         | ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/fpga/fpga-bridge.h:151:1: note: previous definition of '__fpga_bridge_register' with type 'struct fpga_bridge *(struct device *, const char *, const struct fpga_bridge_ops *, void *, struct module *)'
     151 | __fpga_bridge_register(struct device *parent, const char *name,
         | ^~~~~~~~~~~~~~~~~~~~~~
>> drivers/fpga/fpga-bridge.c:403:6: error: redefinition of 'fpga_bridge_unregister'
     403 | void fpga_bridge_unregister(struct fpga_bridge *bridge)
         |      ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/fpga/fpga-bridge.h:158:20: note: previous definition of 'fpga_bridge_unregister' with type 'void(struct fpga_bridge *)'
     158 | static inline void fpga_bridge_unregister(struct fpga_bridge *br)
         |                    ^~~~~~~~~~~~~~~~~~~~~~


vim +/fpga_bridge_enable +29 drivers/fpga/fpga-bridge.c

21aeda950c5f84 Alan Tull      2016-11-01   21  
21aeda950c5f84 Alan Tull      2016-11-01   22  /**
21aeda950c5f84 Alan Tull      2016-11-01   23   * fpga_bridge_enable - Enable transactions on the bridge
21aeda950c5f84 Alan Tull      2016-11-01   24   *
21aeda950c5f84 Alan Tull      2016-11-01   25   * @bridge: FPGA bridge
21aeda950c5f84 Alan Tull      2016-11-01   26   *
21aeda950c5f84 Alan Tull      2016-11-01   27   * Return: 0 for success, error code otherwise.
21aeda950c5f84 Alan Tull      2016-11-01   28   */
21aeda950c5f84 Alan Tull      2016-11-01  @29  int fpga_bridge_enable(struct fpga_bridge *bridge)
21aeda950c5f84 Alan Tull      2016-11-01   30  {
21aeda950c5f84 Alan Tull      2016-11-01   31  	dev_dbg(&bridge->dev, "enable\n");
21aeda950c5f84 Alan Tull      2016-11-01   32  
b1a91ca25f15b6 Marco Pagani   2024-02-01   33  	if (bridge->br_ops->enable_set)
21aeda950c5f84 Alan Tull      2016-11-01   34  		return bridge->br_ops->enable_set(bridge, 1);
21aeda950c5f84 Alan Tull      2016-11-01   35  
21aeda950c5f84 Alan Tull      2016-11-01   36  	return 0;
21aeda950c5f84 Alan Tull      2016-11-01   37  }
21aeda950c5f84 Alan Tull      2016-11-01   38  EXPORT_SYMBOL_GPL(fpga_bridge_enable);
21aeda950c5f84 Alan Tull      2016-11-01   39  
21aeda950c5f84 Alan Tull      2016-11-01   40  /**
21aeda950c5f84 Alan Tull      2016-11-01   41   * fpga_bridge_disable - Disable transactions on the bridge
21aeda950c5f84 Alan Tull      2016-11-01   42   *
21aeda950c5f84 Alan Tull      2016-11-01   43   * @bridge: FPGA bridge
21aeda950c5f84 Alan Tull      2016-11-01   44   *
21aeda950c5f84 Alan Tull      2016-11-01   45   * Return: 0 for success, error code otherwise.
21aeda950c5f84 Alan Tull      2016-11-01   46   */
21aeda950c5f84 Alan Tull      2016-11-01  @47  int fpga_bridge_disable(struct fpga_bridge *bridge)
21aeda950c5f84 Alan Tull      2016-11-01   48  {
21aeda950c5f84 Alan Tull      2016-11-01   49  	dev_dbg(&bridge->dev, "disable\n");
21aeda950c5f84 Alan Tull      2016-11-01   50  
b1a91ca25f15b6 Marco Pagani   2024-02-01   51  	if (bridge->br_ops->enable_set)
21aeda950c5f84 Alan Tull      2016-11-01   52  		return bridge->br_ops->enable_set(bridge, 0);
21aeda950c5f84 Alan Tull      2016-11-01   53  
21aeda950c5f84 Alan Tull      2016-11-01   54  	return 0;
21aeda950c5f84 Alan Tull      2016-11-01   55  }
21aeda950c5f84 Alan Tull      2016-11-01   56  EXPORT_SYMBOL_GPL(fpga_bridge_disable);
21aeda950c5f84 Alan Tull      2016-11-01   57  
1da11f822042eb Marco Pagani   2024-03-22   58  static struct fpga_bridge *__fpga_bridge_get(struct device *bridge_dev,
21aeda950c5f84 Alan Tull      2016-11-01   59  					     struct fpga_image_info *info)
21aeda950c5f84 Alan Tull      2016-11-01   60  {
21aeda950c5f84 Alan Tull      2016-11-01   61  	struct fpga_bridge *bridge;
21aeda950c5f84 Alan Tull      2016-11-01   62  
1da11f822042eb Marco Pagani   2024-03-22   63  	bridge = to_fpga_bridge(bridge_dev);
21aeda950c5f84 Alan Tull      2016-11-01   64  
21aeda950c5f84 Alan Tull      2016-11-01   65  	bridge->info = info;
21aeda950c5f84 Alan Tull      2016-11-01   66  
1da11f822042eb Marco Pagani   2024-03-22   67  	if (!mutex_trylock(&bridge->mutex))
1da11f822042eb Marco Pagani   2024-03-22   68  		return ERR_PTR(-EBUSY);
21aeda950c5f84 Alan Tull      2016-11-01   69  
1da11f822042eb Marco Pagani   2024-03-22   70  	if (!try_module_get(bridge->br_ops_owner)) {
1da11f822042eb Marco Pagani   2024-03-22   71  		mutex_unlock(&bridge->mutex);
1da11f822042eb Marco Pagani   2024-03-22   72  		return ERR_PTR(-ENODEV);
1da11f822042eb Marco Pagani   2024-03-22   73  	}
21aeda950c5f84 Alan Tull      2016-11-01   74  
21aeda950c5f84 Alan Tull      2016-11-01   75  	dev_dbg(&bridge->dev, "get\n");
21aeda950c5f84 Alan Tull      2016-11-01   76  
21aeda950c5f84 Alan Tull      2016-11-01   77  	return bridge;
21aeda950c5f84 Alan Tull      2016-11-01   78  }
9c1c4b2753fea3 Alan Tull      2017-11-15   79  
9c1c4b2753fea3 Alan Tull      2017-11-15   80  /**
e7555cf6c263d9 Tom Rix        2021-06-08   81   * of_fpga_bridge_get - get an exclusive reference to an fpga bridge
9c1c4b2753fea3 Alan Tull      2017-11-15   82   *
8e665c9c1affcb Marco Pagani   2023-07-06   83   * @np: node pointer of an FPGA bridge.
8e665c9c1affcb Marco Pagani   2023-07-06   84   * @info: fpga image specific information.
9c1c4b2753fea3 Alan Tull      2017-11-15   85   *
8e665c9c1affcb Marco Pagani   2023-07-06   86   * Return:
8e665c9c1affcb Marco Pagani   2023-07-06   87   * * fpga_bridge struct pointer if successful.
8e665c9c1affcb Marco Pagani   2023-07-06   88   * * -EBUSY if someone already has a reference to the bridge.
8e665c9c1affcb Marco Pagani   2023-07-06   89   * * -ENODEV if @np is not an FPGA Bridge or can't take parent driver refcount.
9c1c4b2753fea3 Alan Tull      2017-11-15   90   */
9c1c4b2753fea3 Alan Tull      2017-11-15  @91  struct fpga_bridge *of_fpga_bridge_get(struct device_node *np,
9c1c4b2753fea3 Alan Tull      2017-11-15   92  				       struct fpga_image_info *info)
9c1c4b2753fea3 Alan Tull      2017-11-15   93  {
1da11f822042eb Marco Pagani   2024-03-22   94  	struct fpga_bridge *bridge;
1da11f822042eb Marco Pagani   2024-03-22   95  	struct device *bridge_dev;
9c1c4b2753fea3 Alan Tull      2017-11-15   96  
1da11f822042eb Marco Pagani   2024-03-22   97  	bridge_dev = class_find_device_by_of_node(&fpga_bridge_class, np);
1da11f822042eb Marco Pagani   2024-03-22   98  	if (!bridge_dev)
9c1c4b2753fea3 Alan Tull      2017-11-15   99  		return ERR_PTR(-ENODEV);
9c1c4b2753fea3 Alan Tull      2017-11-15  100  
1da11f822042eb Marco Pagani   2024-03-22  101  	bridge = __fpga_bridge_get(bridge_dev, info);
1da11f822042eb Marco Pagani   2024-03-22  102  	if (IS_ERR(bridge))
1da11f822042eb Marco Pagani   2024-03-22  103  		put_device(bridge_dev);
1da11f822042eb Marco Pagani   2024-03-22  104  
1da11f822042eb Marco Pagani   2024-03-22  105  	return bridge;
9c1c4b2753fea3 Alan Tull      2017-11-15  106  }
21aeda950c5f84 Alan Tull      2016-11-01  107  EXPORT_SYMBOL_GPL(of_fpga_bridge_get);
21aeda950c5f84 Alan Tull      2016-11-01  108  
9c1c4b2753fea3 Alan Tull      2017-11-15  109  static int fpga_bridge_dev_match(struct device *dev, const void *data)
9c1c4b2753fea3 Alan Tull      2017-11-15  110  {
9c1c4b2753fea3 Alan Tull      2017-11-15  111  	return dev->parent == data;
9c1c4b2753fea3 Alan Tull      2017-11-15  112  }
9c1c4b2753fea3 Alan Tull      2017-11-15  113  
9c1c4b2753fea3 Alan Tull      2017-11-15  114  /**
e7555cf6c263d9 Tom Rix        2021-06-08  115   * fpga_bridge_get - get an exclusive reference to an fpga bridge
9c1c4b2753fea3 Alan Tull      2017-11-15  116   * @dev:	parent device that fpga bridge was registered with
7ef1a2c1c9dffa Marco Pagani   2023-03-01  117   * @info:	fpga image specific information
9c1c4b2753fea3 Alan Tull      2017-11-15  118   *
e7555cf6c263d9 Tom Rix        2021-06-08  119   * Given a device, get an exclusive reference to an fpga bridge.
9c1c4b2753fea3 Alan Tull      2017-11-15  120   *
b4d9a0e5ca1396 Alan Tull      2018-09-12  121   * Return: fpga bridge struct or IS_ERR() condition containing error code.
9c1c4b2753fea3 Alan Tull      2017-11-15  122   */
9c1c4b2753fea3 Alan Tull      2017-11-15 @123  struct fpga_bridge *fpga_bridge_get(struct device *dev,
9c1c4b2753fea3 Alan Tull      2017-11-15  124  				    struct fpga_image_info *info)
9c1c4b2753fea3 Alan Tull      2017-11-15  125  {
1da11f822042eb Marco Pagani   2024-03-22  126  	struct fpga_bridge *bridge;
9c1c4b2753fea3 Alan Tull      2017-11-15  127  	struct device *bridge_dev;
9c1c4b2753fea3 Alan Tull      2017-11-15  128  
7bb2d2190d4326 Ivan Orlov     2023-08-11  129  	bridge_dev = class_find_device(&fpga_bridge_class, NULL, dev,
9c1c4b2753fea3 Alan Tull      2017-11-15  130  				       fpga_bridge_dev_match);
9c1c4b2753fea3 Alan Tull      2017-11-15  131  	if (!bridge_dev)
9c1c4b2753fea3 Alan Tull      2017-11-15  132  		return ERR_PTR(-ENODEV);
9c1c4b2753fea3 Alan Tull      2017-11-15  133  
1da11f822042eb Marco Pagani   2024-03-22  134  	bridge = __fpga_bridge_get(bridge_dev, info);
1da11f822042eb Marco Pagani   2024-03-22  135  	if (IS_ERR(bridge))
1da11f822042eb Marco Pagani   2024-03-22  136  		put_device(bridge_dev);
1da11f822042eb Marco Pagani   2024-03-22  137  
1da11f822042eb Marco Pagani   2024-03-22  138  	return bridge;
9c1c4b2753fea3 Alan Tull      2017-11-15  139  }
9c1c4b2753fea3 Alan Tull      2017-11-15  140  EXPORT_SYMBOL_GPL(fpga_bridge_get);
9c1c4b2753fea3 Alan Tull      2017-11-15  141  
21aeda950c5f84 Alan Tull      2016-11-01  142  /**
21aeda950c5f84 Alan Tull      2016-11-01  143   * fpga_bridge_put - release a reference to a bridge
21aeda950c5f84 Alan Tull      2016-11-01  144   *
21aeda950c5f84 Alan Tull      2016-11-01  145   * @bridge: FPGA bridge
21aeda950c5f84 Alan Tull      2016-11-01  146   */
21aeda950c5f84 Alan Tull      2016-11-01 @147  void fpga_bridge_put(struct fpga_bridge *bridge)
21aeda950c5f84 Alan Tull      2016-11-01  148  {
21aeda950c5f84 Alan Tull      2016-11-01  149  	dev_dbg(&bridge->dev, "put\n");
21aeda950c5f84 Alan Tull      2016-11-01  150  
21aeda950c5f84 Alan Tull      2016-11-01  151  	bridge->info = NULL;
1da11f822042eb Marco Pagani   2024-03-22  152  	module_put(bridge->br_ops_owner);
21aeda950c5f84 Alan Tull      2016-11-01  153  	mutex_unlock(&bridge->mutex);
21aeda950c5f84 Alan Tull      2016-11-01  154  	put_device(&bridge->dev);
21aeda950c5f84 Alan Tull      2016-11-01  155  }
21aeda950c5f84 Alan Tull      2016-11-01  156  EXPORT_SYMBOL_GPL(fpga_bridge_put);
21aeda950c5f84 Alan Tull      2016-11-01  157  
21aeda950c5f84 Alan Tull      2016-11-01  158  /**
21aeda950c5f84 Alan Tull      2016-11-01  159   * fpga_bridges_enable - enable bridges in a list
21aeda950c5f84 Alan Tull      2016-11-01  160   * @bridge_list: list of FPGA bridges
21aeda950c5f84 Alan Tull      2016-11-01  161   *
21aeda950c5f84 Alan Tull      2016-11-01  162   * Enable each bridge in the list. If list is empty, do nothing.
21aeda950c5f84 Alan Tull      2016-11-01  163   *
8e665c9c1affcb Marco Pagani   2023-07-06  164   * Return: 0 for success or empty bridge list or an error code otherwise.
21aeda950c5f84 Alan Tull      2016-11-01  165   */
21aeda950c5f84 Alan Tull      2016-11-01 @166  int fpga_bridges_enable(struct list_head *bridge_list)
21aeda950c5f84 Alan Tull      2016-11-01  167  {
21aeda950c5f84 Alan Tull      2016-11-01  168  	struct fpga_bridge *bridge;
21aeda950c5f84 Alan Tull      2016-11-01  169  	int ret;
21aeda950c5f84 Alan Tull      2016-11-01  170  
c37235cce31d5e Moritz Fischer 2017-03-10  171  	list_for_each_entry(bridge, bridge_list, node) {
21aeda950c5f84 Alan Tull      2016-11-01  172  		ret = fpga_bridge_enable(bridge);
21aeda950c5f84 Alan Tull      2016-11-01  173  		if (ret)
21aeda950c5f84 Alan Tull      2016-11-01  174  			return ret;
21aeda950c5f84 Alan Tull      2016-11-01  175  	}
21aeda950c5f84 Alan Tull      2016-11-01  176  
21aeda950c5f84 Alan Tull      2016-11-01  177  	return 0;
21aeda950c5f84 Alan Tull      2016-11-01  178  }
21aeda950c5f84 Alan Tull      2016-11-01  179  EXPORT_SYMBOL_GPL(fpga_bridges_enable);
21aeda950c5f84 Alan Tull      2016-11-01  180  
21aeda950c5f84 Alan Tull      2016-11-01  181  /**
21aeda950c5f84 Alan Tull      2016-11-01  182   * fpga_bridges_disable - disable bridges in a list
21aeda950c5f84 Alan Tull      2016-11-01  183   *
21aeda950c5f84 Alan Tull      2016-11-01  184   * @bridge_list: list of FPGA bridges
21aeda950c5f84 Alan Tull      2016-11-01  185   *
21aeda950c5f84 Alan Tull      2016-11-01  186   * Disable each bridge in the list. If list is empty, do nothing.
21aeda950c5f84 Alan Tull      2016-11-01  187   *
8e665c9c1affcb Marco Pagani   2023-07-06  188   * Return: 0 for success or empty bridge list or an error code otherwise.
21aeda950c5f84 Alan Tull      2016-11-01  189   */
21aeda950c5f84 Alan Tull      2016-11-01 @190  int fpga_bridges_disable(struct list_head *bridge_list)
21aeda950c5f84 Alan Tull      2016-11-01  191  {
21aeda950c5f84 Alan Tull      2016-11-01  192  	struct fpga_bridge *bridge;
21aeda950c5f84 Alan Tull      2016-11-01  193  	int ret;
21aeda950c5f84 Alan Tull      2016-11-01  194  
c37235cce31d5e Moritz Fischer 2017-03-10  195  	list_for_each_entry(bridge, bridge_list, node) {
21aeda950c5f84 Alan Tull      2016-11-01  196  		ret = fpga_bridge_disable(bridge);
21aeda950c5f84 Alan Tull      2016-11-01  197  		if (ret)
21aeda950c5f84 Alan Tull      2016-11-01  198  			return ret;
21aeda950c5f84 Alan Tull      2016-11-01  199  	}
21aeda950c5f84 Alan Tull      2016-11-01  200  
21aeda950c5f84 Alan Tull      2016-11-01  201  	return 0;
21aeda950c5f84 Alan Tull      2016-11-01  202  }
21aeda950c5f84 Alan Tull      2016-11-01  203  EXPORT_SYMBOL_GPL(fpga_bridges_disable);
21aeda950c5f84 Alan Tull      2016-11-01  204  
21aeda950c5f84 Alan Tull      2016-11-01  205  /**
21aeda950c5f84 Alan Tull      2016-11-01  206   * fpga_bridges_put - put bridges
21aeda950c5f84 Alan Tull      2016-11-01  207   *
21aeda950c5f84 Alan Tull      2016-11-01  208   * @bridge_list: list of FPGA bridges
21aeda950c5f84 Alan Tull      2016-11-01  209   *
21aeda950c5f84 Alan Tull      2016-11-01  210   * For each bridge in the list, put the bridge and remove it from the list.
21aeda950c5f84 Alan Tull      2016-11-01  211   * If list is empty, do nothing.
21aeda950c5f84 Alan Tull      2016-11-01  212   */
21aeda950c5f84 Alan Tull      2016-11-01 @213  void fpga_bridges_put(struct list_head *bridge_list)
21aeda950c5f84 Alan Tull      2016-11-01  214  {
c37235cce31d5e Moritz Fischer 2017-03-10  215  	struct fpga_bridge *bridge, *next;
21aeda950c5f84 Alan Tull      2016-11-01  216  	unsigned long flags;
21aeda950c5f84 Alan Tull      2016-11-01  217  
c37235cce31d5e Moritz Fischer 2017-03-10  218  	list_for_each_entry_safe(bridge, next, bridge_list, node) {
21aeda950c5f84 Alan Tull      2016-11-01  219  		fpga_bridge_put(bridge);
21aeda950c5f84 Alan Tull      2016-11-01  220  
21aeda950c5f84 Alan Tull      2016-11-01  221  		spin_lock_irqsave(&bridge_list_lock, flags);
21aeda950c5f84 Alan Tull      2016-11-01  222  		list_del(&bridge->node);
21aeda950c5f84 Alan Tull      2016-11-01  223  		spin_unlock_irqrestore(&bridge_list_lock, flags);
21aeda950c5f84 Alan Tull      2016-11-01  224  	}
21aeda950c5f84 Alan Tull      2016-11-01  225  }
21aeda950c5f84 Alan Tull      2016-11-01  226  EXPORT_SYMBOL_GPL(fpga_bridges_put);
21aeda950c5f84 Alan Tull      2016-11-01  227  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

