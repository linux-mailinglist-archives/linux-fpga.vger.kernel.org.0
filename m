Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2D14957F3
	for <lists+linux-fpga@lfdr.de>; Fri, 21 Jan 2022 02:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378039AbiAUBuY (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 20 Jan 2022 20:50:24 -0500
Received: from mga17.intel.com ([192.55.52.151]:6503 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245241AbiAUBuX (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 20 Jan 2022 20:50:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642729823; x=1674265823;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=tpbhxe8BYS+0LcYtcG0xiqbZ8GFkXlLnMFhdR13Wy68=;
  b=l+kxk21iBVOQWRzkx9ynMSKdm99GsooM0IEjH/g6GfnbkKYemFx5mBbf
   JeTii8V+uCxQu9G23HT9Rk6ay17lCOmy8tp9zHdolHd3XZfO23ZPEhaQs
   ng54PzRYMP0Ve/lwDXmWj1JW/2T0fBzdSBFenkKy60t5kSOOW+hJOCIvP
   r/NjtHSoXcxO5hMkMHaFTWr9IXZDlOJTdEA++O3hedQ1/zDQThB+r4vUk
   n6ePk53vea4xN2XXEb49+yPi92McO79tim4ZNFlHfvPScHSDqpm1JQmOu
   9B9DyfpV2BP205jtZ4Mw754z/HlEz7c97ttpk1a8xsWSMHc1oAQnWNFA1
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10233"; a="226213756"
X-IronPort-AV: E=Sophos;i="5.88,303,1635231600"; 
   d="scan'208";a="226213756"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2022 17:50:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,303,1635231600"; 
   d="scan'208";a="493677604"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.68])
  by orsmga002.jf.intel.com with ESMTP; 20 Jan 2022 17:50:17 -0800
Date:   Fri, 21 Jan 2022 09:42:13 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Lizhi Hou <lizhi.hou@xilinx.com>
Cc:     robh@kernel.org, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org, maxz@xilinx.com,
        sonal.santan@xilinx.com, yliu@xilinx.com, michal.simek@xilinx.com,
        stefanos@xilinx.com, devicetree@vger.kernel.org, trix@redhat.com,
        mdf@kernel.org, dwmw2@infradead.org, Max Zhen <max.zhen@xilinx.com>
Subject: Re: [PATCH V4 XRT Alveo Infrastructure 3/5] of: create empty of root
Message-ID: <20220121014213.GA1102476@yilunxu-OptiPlex-7050>
References: <20220105225013.1567871-1-lizhi.hou@xilinx.com>
 <20220105225013.1567871-4-lizhi.hou@xilinx.com>
 <20220111042920.GA979169@yilunxu-OptiPlex-7050>
 <72a8ee48-b38b-b72c-bcd4-78908af5d829@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <72a8ee48-b38b-b72c-bcd4-78908af5d829@xilinx.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Wed, Jan 19, 2022 at 10:59:48AM -0800, Lizhi Hou wrote:
> Hi Yilun,
> 
> Thanks for your comments. Overall, we made the code change based on Rob's
> comments on previous patch set. Please see my inline comments for detail.
> 
> Rob, please provide your guidance here.
> 
> On 1/10/22 8:29 PM, Xu Yilun wrote:
> > On Wed, Jan 05, 2022 at 02:50:11PM -0800, Lizhi Hou wrote:
> > > When OF_FLATTREE is selected and there is not a device tree, create an
> > > empty device tree root node. of/unittest.c code is referenced.
> > > 
> > > Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
> > > Signed-off-by: Max Zhen <max.zhen@xilinx.com>
> > > Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
> > > ---
> > >   drivers/of/Makefile        |  5 +++
> > >   drivers/of/fdt.c           | 90 ++++++++++++++++++++++++++++++++++++++
> > >   drivers/of/fdt_default.dts |  5 +++
> > >   drivers/of/of_private.h    | 17 +++++++
> > >   drivers/of/unittest.c      | 72 ++----------------------------
> > >   5 files changed, 120 insertions(+), 69 deletions(-)
> > >   create mode 100644 drivers/of/fdt_default.dts
> > > 
> > > diff --git a/drivers/of/Makefile b/drivers/of/Makefile
> > > index c13b982084a3..a2989055c578 100644
> > > --- a/drivers/of/Makefile
> > > +++ b/drivers/of/Makefile
> > > @@ -1,5 +1,6 @@
> > >   # SPDX-License-Identifier: GPL-2.0
> > >   obj-y = base.o device.o platform.o property.o
> > > +
> > remove the blank line.
> Will remove.
> > 
> > >   obj-$(CONFIG_OF_KOBJ) += kobj.o
> > >   obj-$(CONFIG_OF_DYNAMIC) += dynamic.o
> > >   obj-$(CONFIG_OF_FLATTREE) += fdt.o
> > > @@ -20,4 +21,8 @@ obj-y       += kexec.o
> > >   endif
> > >   endif
> > > 
> > > +ifndef CONFIG_OF_UNITTEST
> > > +obj-$(CONFIG_OF_FLATTREE) += fdt_default.dtb.o
> > > +endif
> > > +
> > Same question as Tom, the unittest should work well with or without
> > of_root, is it? So creating an empty root will not affect unittest, so
> > why so many ifdefs for CONFIG_OF_UNITTEST?
> 
> Based on Rob's comment in
> https://lore.kernel.org/lkml/YaWFksVvfQQWqKcG@robh.at.kernel.org/, it needs
> to have a unified code to set of_root with or without CONFIG_OF_UNITTEST
> defined.  So the unified code works as this during boot
> 
> 1. With CONFIG_OF_UNITEST define, of_root is set to base tree
> defined/compiled in testcases.dtb.o
> 
> 2. Without CONFIG_OF_UNITEST, of_root is set to base tree defined/compiled
> in fdt_default.dtb.o
> 
> > 
> > >   obj-$(CONFIG_OF_UNITTEST) += unittest-data/
> > > diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> > > index 4546572af24b..66ef9ac97829 100644
> > > --- a/drivers/of/fdt.c
> > > +++ b/drivers/of/fdt.c
> > > @@ -466,6 +466,96 @@ void *of_fdt_unflatten_tree(const unsigned long *blob,
> > >   }
> > >   EXPORT_SYMBOL_GPL(of_fdt_unflatten_tree);
> > > 
> > > +static int __init of_fdt_root_init(void)
> > > +{
> > > +     struct device_node *dt = NULL, *np;
> > > +     void *fdt = NULL, *fdt_aligned;
> > > +     struct property *prop = NULL;
> > > +     __be32 *val = NULL;
> > > +     int size, rc = 0;
> > > +
> > > +#if !defined(CONFIG_OF_UNITTEST)
> > > +     if (of_root)
> > > +             return 0;
> > > +#endif
> > > +     size = __dtb_fdt_default_end - __dtb_fdt_default_begin;
> > > +
> > > +     fdt = kmalloc(size + FDT_ALIGN_SIZE, GFP_KERNEL);
> > > +     if (!fdt)
> > > +             return -ENOMEM;
> > > +
> > > +     fdt_aligned = PTR_ALIGN(fdt, FDT_ALIGN_SIZE);
> > > +     memcpy(fdt_aligned, __dtb_fdt_default_begin, size);
> > > +
> > > +     if (!of_fdt_unflatten_tree((const unsigned long *)fdt_aligned,
> > > +                                NULL, &dt)) {
> > > +             pr_warn("%s: unflatten default tree failed\n", __func__);
> > > +             kfree(fdt);
> > > +             return -ENODATA;
> > > +     }
> > > +     if (!dt) {
> > > +             pr_warn("%s: empty default tree\n", __func__);
> > > +             kfree(fdt);
> > > +             return -ENODATA;
> > > +     }
> > > +
> > > +     /*
> > > +      * This lock normally encloses of_resolve_phandles()
> > > +      */
> > > +     of_overlay_mutex_lock();
> > > +
> > > +     rc = of_resolve_phandles(dt);
> > > +     if (rc) {
> > > +             pr_err("%s: Failed to resolve phandles (rc=%i)\n", __func__, rc);
> > > +             goto failed;
> > > +     }
> > > +
> > > +     if (!of_root) {
> > > +             prop = kcalloc(2, sizeof(*prop), GFP_KERNEL);
> > > +             if (!prop) {
> > > +                     rc = -ENOMEM;
> > > +                     goto failed;
> > > +             }
> > > +             val = kzalloc(sizeof(*val), GFP_KERNEL);
> > > +             if (!val) {
> > > +                     rc = -ENOMEM;
> > > +                     goto failed;
> > > +             }
> > > +             *val = cpu_to_be32(sizeof(void *) / sizeof(u32));
> > > +
> > > +             prop->name = "#address-cells";
> > > +             prop->value = val;
> > > +             prop->length = sizeof(u32);
> > > +             of_add_property(dt, prop);
> > > +             prop++;
> > > +             prop->name = "#size-cells";
> > > +             prop->value = val;
> > > +             prop->length = sizeof(u32);
> > > +             of_add_property(dt, prop);
> > > +             of_root = dt;
> > > +             for_each_of_allnodes(np)
> > > +                     __of_attach_node_sysfs(np);
> > > +             of_aliases = of_find_node_by_path("/aliases");
> > > +             of_chosen = of_find_node_by_path("/chosen");
> > > +             of_overlay_mutex_unlock();
> > > +pr_info("OF ROOT FLAG %lx\n", of_root->_flags);
> > > +             return 0;
> > > +     }
> > > +
> > > +     unittest_data_add(dt);
> > It's confusing to me. If we need to share some functions with unittest,
> > make a new clearly defined (and named) function.
> 
> unittest_data_add() is not shared function. If CONFIG_OF_UNITTEST is not
> defined, this is a null function (please see of_private.h). I just followed
> the existing code style. e.g. of_property_notify() in of_private.h.
> 
> Would adding some comments to describe this be good enough?
> 
> > 
> > > +
> > > +     of_overlay_mutex_unlock();
> > > +
> > > +     return 0;
> > > +
> > > +failed:
> > > +     of_overlay_mutex_unlock();
> > > +     kfree(val);
> > > +     kfree(prop);
> > > +     return rc;
> > > +}
> > > +pure_initcall(of_fdt_root_init);
> > Is it better we have a new Kconfig option for the empty tree creation.
> Sure, if needed.
> > 
> > > +
> > >   /* Everything below here references initial_boot_params directly. */
> > >   int __initdata dt_root_addr_cells;
> > >   int __initdata dt_root_size_cells;
> > > diff --git a/drivers/of/fdt_default.dts b/drivers/of/fdt_default.dts
> > > new file mode 100644
> > > index 000000000000..d1f12a76dfc6
> > > --- /dev/null
> > > +++ b/drivers/of/fdt_default.dts
> > > @@ -0,0 +1,5 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/dts-v1/;
> > > +
> > > +/ {
> > > +};
> > > diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
> > > index 631489f7f8c0..1ef93bccfdba 100644
> > > --- a/drivers/of/of_private.h
> > > +++ b/drivers/of/of_private.h
> > > @@ -41,6 +41,18 @@ extern struct mutex of_mutex;
> > >   extern struct list_head aliases_lookup;
> > >   extern struct kset *of_kset;
> > > 
> > > +#if defined(CONFIG_OF_UNITTEST)
> > > +extern u8 __dtb_testcases_begin[];
> > > +extern u8 __dtb_testcases_end[];
> > > +#define __dtb_fdt_default_begin              __dtb_testcases_begin
> > > +#define __dtb_fdt_default_end                __dtb_testcases_end
> > Maybe we don't have to use the test dt data, stick to the default empty
> > fdt is fine?
> 
> I am not sure I understand the point. test dt data contains a lot test nodes
> and we should not create those nodes if CONFIG_OF_UNITTEST is not defined.
> 
> Are you asking that we create empty of_root here and test nodes are created
> in unittest.c? I believe that was we tried to do with previous patch. Is
> this the same ask within your second comment?

Yes, generally this is what I mean. I think you may have some
misunderstanding for Rob's comments. My understanding is, to move the code
from unittest to the of core, refactor them and make clearly defined
functions, and let unittest call these functions.

It is generally not reasonable the core uses help functions or test data
from unittest.

> 
> We are open to change it back as previous patch does if needed.
> 
> Rob, do you have any comment here?
> 
> > 
> > > +void __init unittest_data_add(struct device_node *dt);
> > > +#else
> > > +extern u8 __dtb_fdt_default_begin[];
> > > +extern u8 __dtb_fdt_default_end[];
> > > +static inline void unittest_data_add(struct device_node *dt) {}
> > > +#endif
> > > +
> > >   #if defined(CONFIG_OF_DYNAMIC)
> > >   extern int of_property_notify(int action, struct device_node *np,
> > >                              struct property *prop, struct property *old_prop);
> > > @@ -84,6 +96,11 @@ static inline void __of_detach_node_sysfs(struct device_node *np) {}
> > > 
> > >   #if defined(CONFIG_OF_RESOLVE)
> > >   int of_resolve_phandles(struct device_node *tree);
> > > +#else
> > > +static inline int of_resolve_phandles(struct device_node *tree)
> > > +{
> > > +     return 0;
> > > +}
> > If we have an empty of_resolve_phandles, does the empty tree creation
> > still works? Or if we don't need this func, just delete in the code.
> 
> test nodes creation requires of_resolve_phandles() and creating empty
> of_root does not. This define is added for unifying the code.

If you don't need the of_resolve_phandles in core code, don't call it.

Thanks,
Yilun

> 
> 
> Thanks,
> 
> Lizhi
> 
> > 
> > Thanks,
> > Yilun
> > 
> > >   #endif
> > > 
> > >   void __of_phandle_cache_inv_entry(phandle handle);
> > > diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
> > > index 8c056972a6dd..745f455235cc 100644
> > > --- a/drivers/of/unittest.c
> > > +++ b/drivers/of/unittest.c
> > > @@ -1402,73 +1402,15 @@ static void attach_node_and_children(struct device_node *np)
> > >    *   unittest_data_add - Reads, copies data from
> > >    *   linked tree and attaches it to the live tree
> > >    */
> > > -static int __init unittest_data_add(void)
> > > +void __init unittest_data_add(struct device_node *dt)
> > >   {
> > > -     void *unittest_data;
> > > -     void *unittest_data_align;
> > > -     struct device_node *unittest_data_node = NULL, *np;
> > > -     /*
> > > -      * __dtb_testcases_begin[] and __dtb_testcases_end[] are magically
> > > -      * created by cmd_dt_S_dtb in scripts/Makefile.lib
> > > -      */
> > > -     extern uint8_t __dtb_testcases_begin[];
> > > -     extern uint8_t __dtb_testcases_end[];
> > > -     const int size = __dtb_testcases_end - __dtb_testcases_begin;
> > > -     int rc;
> > > -     void *ret;
> > > -
> > > -     if (!size) {
> > > -             pr_warn("%s: testcases is empty\n", __func__);
> > > -             return -ENODATA;
> > > -     }
> > > -
> > > -     /* creating copy */
> > > -     unittest_data = kmalloc(size + FDT_ALIGN_SIZE, GFP_KERNEL);
> > > -     if (!unittest_data)
> > > -             return -ENOMEM;
> > > -
> > > -     unittest_data_align = PTR_ALIGN(unittest_data, FDT_ALIGN_SIZE);
> > > -     memcpy(unittest_data_align, __dtb_testcases_begin, size);
> > > -
> > > -     ret = of_fdt_unflatten_tree(unittest_data_align, NULL, &unittest_data_node);
> > > -     if (!ret) {
> > > -             pr_warn("%s: unflatten testcases tree failed\n", __func__);
> > > -             kfree(unittest_data);
> > > -             return -ENODATA;
> > > -     }
> > > -     if (!unittest_data_node) {
> > > -             pr_warn("%s: testcases tree is empty\n", __func__);
> > > -             kfree(unittest_data);
> > > -             return -ENODATA;
> > > -     }
> > > -
> > > -     /*
> > > -      * This lock normally encloses of_resolve_phandles()
> > > -      */
> > > -     of_overlay_mutex_lock();
> > > -
> > > -     rc = of_resolve_phandles(unittest_data_node);
> > > -     if (rc) {
> > > -             pr_err("%s: Failed to resolve phandles (rc=%i)\n", __func__, rc);
> > > -             of_overlay_mutex_unlock();
> > > -             return -EINVAL;
> > > -     }
> > > -
> > > -     if (!of_root) {
> > > -             of_root = unittest_data_node;
> > > -             for_each_of_allnodes(np)
> > > -                     __of_attach_node_sysfs(np);
> > > -             of_aliases = of_find_node_by_path("/aliases");
> > > -             of_chosen = of_find_node_by_path("/chosen");
> > > -             of_overlay_mutex_unlock();
> > > -             return 0;
> > > -     }
> > > +     struct device_node *np;
> > > 
> > >        EXPECT_BEGIN(KERN_INFO,
> > >                     "Duplicate name in testcase-data, renamed to \"duplicate-name#1\"");
> > > 
> > >        /* attach the sub-tree to live tree */
> > > -     np = unittest_data_node->child;
> > > +     np = dt->child;
> > >        while (np) {
> > >                struct device_node *next = np->sibling;
> > > 
> > > @@ -1479,10 +1421,6 @@ static int __init unittest_data_add(void)
> > > 
> > >        EXPECT_END(KERN_INFO,
> > >                   "Duplicate name in testcase-data, renamed to \"duplicate-name#1\"");
> > > -
> > > -     of_overlay_mutex_unlock();
> > > -
> > > -     return 0;
> > >   }
> > > 
> > >   #ifdef CONFIG_OF_OVERLAY
> > > @@ -3258,7 +3196,6 @@ static inline __init void of_unittest_overlay_high_level(void) {}
> > >   static int __init of_unittest(void)
> > >   {
> > >        struct device_node *np;
> > > -     int res;
> > > 
> > >        pr_info("start of unittest - you will see error messages\n");
> > > 
> > > @@ -3267,9 +3204,6 @@ static int __init of_unittest(void)
> > >        if (IS_ENABLED(CONFIG_UML))
> > >                unittest_unflatten_overlay_base();
> > > 
> > > -     res = unittest_data_add();
> > > -     if (res)
> > > -             return res;
> > >        if (!of_aliases)
> > >                of_aliases = of_find_node_by_path("/aliases");
> > > 
> > > --
> > > 2.27.0
