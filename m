Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45EFF496368
	for <lists+linux-fpga@lfdr.de>; Fri, 21 Jan 2022 17:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351602AbiAUQ6E (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 21 Jan 2022 11:58:04 -0500
Received: from mail-bn7nam10on2049.outbound.protection.outlook.com ([40.107.92.49]:27991
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1379547AbiAUQz3 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 21 Jan 2022 11:55:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nTYUJ8kUAJFZcRYTZT1KsjxaNjoCmIiQwSxRLRTiwZ7yEO3Rv69uoz1uD6/tRQdEauGGYXZ4xvSiHND9jnYrmVNfdRBavgIoz5H8yFsLwK6+vih2NrpJBE19dVCs1qMWhhGaM2/WZ+xS0qAfEALFjZ4UlIqLwrstkKmhm39/WDHcXTffDdDAcBETMfHzxyxtdZTd79HKmJt/oZ3RIT8J3VLSXm5bXCal8Hssy6cTPFi+B9I3W2St7Jkmq48VvrjNoU+YMDLYBWdU5bs7qXnbFZSOMlT6oAsgkpo2PFCmNj93BBGNB9BaSR9mWSWOpbo+KjCIIGEZrGrdrieFrEYJGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2TcYmwFZOQRgZxnXyZfgPXOo7zoqJ+Ij+rICIYrejX0=;
 b=VYslMu/GJEMFgdzPvILfmaxvFA0pXNaC4sX0s8teF7Ev7iOwtiuC/ESRtytUzqLEF2dDvMh8kKkQcXpL4sdz59iKziRXFbi89VB0ETLSygwaVbIy1TTBVl7V+L2wOAtZxpLsHdLCG1ghxJkPPpa2Sqa03Qo5T1FBKLrYMy/4149MQGdGVSCd0/YQjq8sJxIPlm3SljFZ0tUB9W5md3UGwTXfWj4UgaWMhkKMMd810OhKYnVD25bU/9q2703DwiFyaTVf+VqMXFBcy4fFR8LJ4u29qB5BONqyREcj1HGYWb+wjl0EVsTR602i+eZqsftw1NJWJRtKt2KkpaUEOZ1rAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=infradead.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2TcYmwFZOQRgZxnXyZfgPXOo7zoqJ+Ij+rICIYrejX0=;
 b=kPmooS5ZuERsm8V6sElGfUEX1PELhjm+RJfnOP0+qT+TCQrQ9w1GURLRKLfJakDzs9I3XyeCHxQm2z3hLb5rHUTF4+HchI06kzPQZx3cYXo4ph1ODGpVVdf8ky914kZrCRcfTVpT+D4rb5xHStwTzqXRBIU38tFnZonXMltM09Y=
Received: from SN4PR0501CA0060.namprd05.prod.outlook.com
 (2603:10b6:803:41::37) by SN4PR0201MB3471.namprd02.prod.outlook.com
 (2603:10b6:803:4f::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.13; Fri, 21 Jan
 2022 16:55:25 +0000
Received: from SN1NAM02FT0016.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:41:cafe::d) by SN4PR0501CA0060.outlook.office365.com
 (2603:10b6:803:41::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.4 via Frontend
 Transport; Fri, 21 Jan 2022 16:55:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0016.mail.protection.outlook.com (10.97.4.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.8 via Frontend Transport; Fri, 21 Jan 2022 16:55:24 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 21 Jan 2022 08:55:24 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 21 Jan 2022 08:55:24 -0800
Envelope-to: dwmw2@infradead.org,
 mdf@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 robh@kernel.org,
 yilun.xu@intel.com
Received: from [10.17.2.60] (port=48550)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1nAxBW-000FE6-6t; Fri, 21 Jan 2022 08:54:46 -0800
Subject: Re: [PATCH V4 XRT Alveo Infrastructure 3/5] of: create empty of root
To:     Xu Yilun <yilun.xu@intel.com>, Lizhi Hou <lizhi.hou@xilinx.com>
CC:     <robh@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-fpga@vger.kernel.org>, <maxz@xilinx.com>,
        <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <mdf@kernel.org>,
        <dwmw2@infradead.org>, Max Zhen <max.zhen@xilinx.com>
References: <20220105225013.1567871-1-lizhi.hou@xilinx.com>
 <20220105225013.1567871-4-lizhi.hou@xilinx.com>
 <20220111042920.GA979169@yilunxu-OptiPlex-7050>
 <72a8ee48-b38b-b72c-bcd4-78908af5d829@xilinx.com>
 <20220121014213.GA1102476@yilunxu-OptiPlex-7050>
From:   Lizhi Hou <lizhi.hou@xilinx.com>
Message-ID: <0908bf90-9190-b645-cfe0-dda20114672b@xilinx.com>
Date:   Fri, 21 Jan 2022 08:54:46 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20220121014213.GA1102476@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 03634b86-b8af-4a93-dd4d-08d9dcfed1cb
X-MS-TrafficTypeDiagnostic: SN4PR0201MB3471:EE_
X-Microsoft-Antispam-PRVS: <SN4PR0201MB3471900A2F309C10DC04700EA15B9@SN4PR0201MB3471.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OG64jQ5H6TrXahLHJS/L+djyOPQbm8ZqjWXqVNvkW7klWJEr8Y9TFEzzwEz0mbGh7gKpoi967lHtw/RYNSq0MFHqB6yw522CPVm97XmwEikfEp3ViaXngPzGCRLcS0KToCKD0acVqPDkJ4xGrqiDnRd7Oe2YAQT3hLYoQrp5lvW012bs3qCOXMmksHZrfVWx7ZnVIRBZrRAAVJNeNznuL87z9b+MiAYpeyLdx/olP09GN3VBGYx4CXIBvhZdXzZ1VFSLPHWB4g0KMt/kK4W6YyKLYaTPeljQoWrcQgocx/kwEK5rkGYx3s1r/oRUQ7NChS/Dp0ymWFpmWbElpVi0Nhl/NsEGuncblyPdsd73g4c/pPtx7UYvJmglAaoLiRWcfwj+5877qlJhLUfI/jzUcKDem3C+k0yo3rZXhgCXC4O5knZNQPoQ4vFw1RLvDT3xJjaPJerhQXWcgcXHa1EePm2M7W27h/WDfGHnQalkPtI4gAQHuqUo6fBVan0FQYNuBygro39cbVQzQ4QCPhaTetK6c0fmpWxRRlob894f8bG5xl5XUd2wqO+wpWVPkG/5/36/Yx7nvF4ukBwZCnY/agWfxQa6ofGTeRxejpdVlAluXtEM8lKDyW1koZ3fQrIWvY5ZREtElYz8Jwe1SFnaLKoZBjNKugmZSV1yG5bHW23bWzEILASMp7NAbdntAz2njqEeyXvV2RD20cV3f87a8mBGPO8pyAdGwUtxViwsghnEOK1qSmIkBE4j4QgDrV9yfGrvbn0EqursxtWNddTIIMdJXuar6nchG08dFArx6Ri+P5EN5g35PXOKsQAQl27lG1ZUgbkQMkkKfx3PDswLsA==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(54906003)(47076005)(26005)(2906002)(82310400004)(336012)(8676002)(2616005)(186003)(83380400001)(356005)(426003)(70206006)(110136005)(31686004)(36860700001)(316002)(30864003)(36756003)(70586007)(53546011)(107886003)(508600001)(9786002)(31696002)(44832011)(966005)(4326008)(5660300002)(7636003)(8936002)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2022 16:55:24.8457
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03634b86-b8af-4a93-dd4d-08d9dcfed1cb
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0016.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0201MB3471
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Yilun,

Thanks for your comments. To make the change simple and clear, I will 
create a patch just for creating empty of_root and submit it to device 
tree subsystem. I will CC you.

Lizhi

On 1/20/22 5:42 PM, Xu Yilun wrote:
>
> On Wed, Jan 19, 2022 at 10:59:48AM -0800, Lizhi Hou wrote:
>> Hi Yilun,
>>
>> Thanks for your comments. Overall, we made the code change based on Rob's
>> comments on previous patch set. Please see my inline comments for detail.
>>
>> Rob, please provide your guidance here.
>>
>> On 1/10/22 8:29 PM, Xu Yilun wrote:
>>> On Wed, Jan 05, 2022 at 02:50:11PM -0800, Lizhi Hou wrote:
>>>> When OF_FLATTREE is selected and there is not a device tree, create an
>>>> empty device tree root node. of/unittest.c code is referenced.
>>>>
>>>> Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
>>>> Signed-off-by: Max Zhen <max.zhen@xilinx.com>
>>>> Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
>>>> ---
>>>>    drivers/of/Makefile        |  5 +++
>>>>    drivers/of/fdt.c           | 90 ++++++++++++++++++++++++++++++++++++++
>>>>    drivers/of/fdt_default.dts |  5 +++
>>>>    drivers/of/of_private.h    | 17 +++++++
>>>>    drivers/of/unittest.c      | 72 ++----------------------------
>>>>    5 files changed, 120 insertions(+), 69 deletions(-)
>>>>    create mode 100644 drivers/of/fdt_default.dts
>>>>
>>>> diff --git a/drivers/of/Makefile b/drivers/of/Makefile
>>>> index c13b982084a3..a2989055c578 100644
>>>> --- a/drivers/of/Makefile
>>>> +++ b/drivers/of/Makefile
>>>> @@ -1,5 +1,6 @@
>>>>    # SPDX-License-Identifier: GPL-2.0
>>>>    obj-y = base.o device.o platform.o property.o
>>>> +
>>> remove the blank line.
>> Will remove.
>>>>    obj-$(CONFIG_OF_KOBJ) += kobj.o
>>>>    obj-$(CONFIG_OF_DYNAMIC) += dynamic.o
>>>>    obj-$(CONFIG_OF_FLATTREE) += fdt.o
>>>> @@ -20,4 +21,8 @@ obj-y       += kexec.o
>>>>    endif
>>>>    endif
>>>>
>>>> +ifndef CONFIG_OF_UNITTEST
>>>> +obj-$(CONFIG_OF_FLATTREE) += fdt_default.dtb.o
>>>> +endif
>>>> +
>>> Same question as Tom, the unittest should work well with or without
>>> of_root, is it? So creating an empty root will not affect unittest, so
>>> why so many ifdefs for CONFIG_OF_UNITTEST?
>> Based on Rob's comment in
>> https://lore.kernel.org/lkml/YaWFksVvfQQWqKcG@robh.at.kernel.org/, it needs
>> to have a unified code to set of_root with or without CONFIG_OF_UNITTEST
>> defined.  So the unified code works as this during boot
>>
>> 1. With CONFIG_OF_UNITEST define, of_root is set to base tree
>> defined/compiled in testcases.dtb.o
>>
>> 2. Without CONFIG_OF_UNITEST, of_root is set to base tree defined/compiled
>> in fdt_default.dtb.o
>>
>>>>    obj-$(CONFIG_OF_UNITTEST) += unittest-data/
>>>> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
>>>> index 4546572af24b..66ef9ac97829 100644
>>>> --- a/drivers/of/fdt.c
>>>> +++ b/drivers/of/fdt.c
>>>> @@ -466,6 +466,96 @@ void *of_fdt_unflatten_tree(const unsigned long *blob,
>>>>    }
>>>>    EXPORT_SYMBOL_GPL(of_fdt_unflatten_tree);
>>>>
>>>> +static int __init of_fdt_root_init(void)
>>>> +{
>>>> +     struct device_node *dt = NULL, *np;
>>>> +     void *fdt = NULL, *fdt_aligned;
>>>> +     struct property *prop = NULL;
>>>> +     __be32 *val = NULL;
>>>> +     int size, rc = 0;
>>>> +
>>>> +#if !defined(CONFIG_OF_UNITTEST)
>>>> +     if (of_root)
>>>> +             return 0;
>>>> +#endif
>>>> +     size = __dtb_fdt_default_end - __dtb_fdt_default_begin;
>>>> +
>>>> +     fdt = kmalloc(size + FDT_ALIGN_SIZE, GFP_KERNEL);
>>>> +     if (!fdt)
>>>> +             return -ENOMEM;
>>>> +
>>>> +     fdt_aligned = PTR_ALIGN(fdt, FDT_ALIGN_SIZE);
>>>> +     memcpy(fdt_aligned, __dtb_fdt_default_begin, size);
>>>> +
>>>> +     if (!of_fdt_unflatten_tree((const unsigned long *)fdt_aligned,
>>>> +                                NULL, &dt)) {
>>>> +             pr_warn("%s: unflatten default tree failed\n", __func__);
>>>> +             kfree(fdt);
>>>> +             return -ENODATA;
>>>> +     }
>>>> +     if (!dt) {
>>>> +             pr_warn("%s: empty default tree\n", __func__);
>>>> +             kfree(fdt);
>>>> +             return -ENODATA;
>>>> +     }
>>>> +
>>>> +     /*
>>>> +      * This lock normally encloses of_resolve_phandles()
>>>> +      */
>>>> +     of_overlay_mutex_lock();
>>>> +
>>>> +     rc = of_resolve_phandles(dt);
>>>> +     if (rc) {
>>>> +             pr_err("%s: Failed to resolve phandles (rc=%i)\n", __func__, rc);
>>>> +             goto failed;
>>>> +     }
>>>> +
>>>> +     if (!of_root) {
>>>> +             prop = kcalloc(2, sizeof(*prop), GFP_KERNEL);
>>>> +             if (!prop) {
>>>> +                     rc = -ENOMEM;
>>>> +                     goto failed;
>>>> +             }
>>>> +             val = kzalloc(sizeof(*val), GFP_KERNEL);
>>>> +             if (!val) {
>>>> +                     rc = -ENOMEM;
>>>> +                     goto failed;
>>>> +             }
>>>> +             *val = cpu_to_be32(sizeof(void *) / sizeof(u32));
>>>> +
>>>> +             prop->name = "#address-cells";
>>>> +             prop->value = val;
>>>> +             prop->length = sizeof(u32);
>>>> +             of_add_property(dt, prop);
>>>> +             prop++;
>>>> +             prop->name = "#size-cells";
>>>> +             prop->value = val;
>>>> +             prop->length = sizeof(u32);
>>>> +             of_add_property(dt, prop);
>>>> +             of_root = dt;
>>>> +             for_each_of_allnodes(np)
>>>> +                     __of_attach_node_sysfs(np);
>>>> +             of_aliases = of_find_node_by_path("/aliases");
>>>> +             of_chosen = of_find_node_by_path("/chosen");
>>>> +             of_overlay_mutex_unlock();
>>>> +pr_info("OF ROOT FLAG %lx\n", of_root->_flags);
>>>> +             return 0;
>>>> +     }
>>>> +
>>>> +     unittest_data_add(dt);
>>> It's confusing to me. If we need to share some functions with unittest,
>>> make a new clearly defined (and named) function.
>> unittest_data_add() is not shared function. If CONFIG_OF_UNITTEST is not
>> defined, this is a null function (please see of_private.h). I just followed
>> the existing code style. e.g. of_property_notify() in of_private.h.
>>
>> Would adding some comments to describe this be good enough?
>>
>>>> +
>>>> +     of_overlay_mutex_unlock();
>>>> +
>>>> +     return 0;
>>>> +
>>>> +failed:
>>>> +     of_overlay_mutex_unlock();
>>>> +     kfree(val);
>>>> +     kfree(prop);
>>>> +     return rc;
>>>> +}
>>>> +pure_initcall(of_fdt_root_init);
>>> Is it better we have a new Kconfig option for the empty tree creation.
>> Sure, if needed.
>>>> +
>>>>    /* Everything below here references initial_boot_params directly. */
>>>>    int __initdata dt_root_addr_cells;
>>>>    int __initdata dt_root_size_cells;
>>>> diff --git a/drivers/of/fdt_default.dts b/drivers/of/fdt_default.dts
>>>> new file mode 100644
>>>> index 000000000000..d1f12a76dfc6
>>>> --- /dev/null
>>>> +++ b/drivers/of/fdt_default.dts
>>>> @@ -0,0 +1,5 @@
>>>> +// SPDX-License-Identifier: GPL-2.0
>>>> +/dts-v1/;
>>>> +
>>>> +/ {
>>>> +};
>>>> diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
>>>> index 631489f7f8c0..1ef93bccfdba 100644
>>>> --- a/drivers/of/of_private.h
>>>> +++ b/drivers/of/of_private.h
>>>> @@ -41,6 +41,18 @@ extern struct mutex of_mutex;
>>>>    extern struct list_head aliases_lookup;
>>>>    extern struct kset *of_kset;
>>>>
>>>> +#if defined(CONFIG_OF_UNITTEST)
>>>> +extern u8 __dtb_testcases_begin[];
>>>> +extern u8 __dtb_testcases_end[];
>>>> +#define __dtb_fdt_default_begin              __dtb_testcases_begin
>>>> +#define __dtb_fdt_default_end                __dtb_testcases_end
>>> Maybe we don't have to use the test dt data, stick to the default empty
>>> fdt is fine?
>> I am not sure I understand the point. test dt data contains a lot test nodes
>> and we should not create those nodes if CONFIG_OF_UNITTEST is not defined.
>>
>> Are you asking that we create empty of_root here and test nodes are created
>> in unittest.c? I believe that was we tried to do with previous patch. Is
>> this the same ask within your second comment?
> Yes, generally this is what I mean. I think you may have some
> misunderstanding for Rob's comments. My understanding is, to move the code
> from unittest to the of core, refactor them and make clearly defined
> functions, and let unittest call these functions.
>
> It is generally not reasonable the core uses help functions or test data
> from unittest.
>
>> We are open to change it back as previous patch does if needed.
>>
>> Rob, do you have any comment here?
>>
>>>> +void __init unittest_data_add(struct device_node *dt);
>>>> +#else
>>>> +extern u8 __dtb_fdt_default_begin[];
>>>> +extern u8 __dtb_fdt_default_end[];
>>>> +static inline void unittest_data_add(struct device_node *dt) {}
>>>> +#endif
>>>> +
>>>>    #if defined(CONFIG_OF_DYNAMIC)
>>>>    extern int of_property_notify(int action, struct device_node *np,
>>>>                               struct property *prop, struct property *old_prop);
>>>> @@ -84,6 +96,11 @@ static inline void __of_detach_node_sysfs(struct device_node *np) {}
>>>>
>>>>    #if defined(CONFIG_OF_RESOLVE)
>>>>    int of_resolve_phandles(struct device_node *tree);
>>>> +#else
>>>> +static inline int of_resolve_phandles(struct device_node *tree)
>>>> +{
>>>> +     return 0;
>>>> +}
>>> If we have an empty of_resolve_phandles, does the empty tree creation
>>> still works? Or if we don't need this func, just delete in the code.
>> test nodes creation requires of_resolve_phandles() and creating empty
>> of_root does not. This define is added for unifying the code.
> If you don't need the of_resolve_phandles in core code, don't call it.
>
> Thanks,
> Yilun
>
>>
>> Thanks,
>>
>> Lizhi
>>
>>> Thanks,
>>> Yilun
>>>
>>>>    #endif
>>>>
>>>>    void __of_phandle_cache_inv_entry(phandle handle);
>>>> diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
>>>> index 8c056972a6dd..745f455235cc 100644
>>>> --- a/drivers/of/unittest.c
>>>> +++ b/drivers/of/unittest.c
>>>> @@ -1402,73 +1402,15 @@ static void attach_node_and_children(struct device_node *np)
>>>>     *   unittest_data_add - Reads, copies data from
>>>>     *   linked tree and attaches it to the live tree
>>>>     */
>>>> -static int __init unittest_data_add(void)
>>>> +void __init unittest_data_add(struct device_node *dt)
>>>>    {
>>>> -     void *unittest_data;
>>>> -     void *unittest_data_align;
>>>> -     struct device_node *unittest_data_node = NULL, *np;
>>>> -     /*
>>>> -      * __dtb_testcases_begin[] and __dtb_testcases_end[] are magically
>>>> -      * created by cmd_dt_S_dtb in scripts/Makefile.lib
>>>> -      */
>>>> -     extern uint8_t __dtb_testcases_begin[];
>>>> -     extern uint8_t __dtb_testcases_end[];
>>>> -     const int size = __dtb_testcases_end - __dtb_testcases_begin;
>>>> -     int rc;
>>>> -     void *ret;
>>>> -
>>>> -     if (!size) {
>>>> -             pr_warn("%s: testcases is empty\n", __func__);
>>>> -             return -ENODATA;
>>>> -     }
>>>> -
>>>> -     /* creating copy */
>>>> -     unittest_data = kmalloc(size + FDT_ALIGN_SIZE, GFP_KERNEL);
>>>> -     if (!unittest_data)
>>>> -             return -ENOMEM;
>>>> -
>>>> -     unittest_data_align = PTR_ALIGN(unittest_data, FDT_ALIGN_SIZE);
>>>> -     memcpy(unittest_data_align, __dtb_testcases_begin, size);
>>>> -
>>>> -     ret = of_fdt_unflatten_tree(unittest_data_align, NULL, &unittest_data_node);
>>>> -     if (!ret) {
>>>> -             pr_warn("%s: unflatten testcases tree failed\n", __func__);
>>>> -             kfree(unittest_data);
>>>> -             return -ENODATA;
>>>> -     }
>>>> -     if (!unittest_data_node) {
>>>> -             pr_warn("%s: testcases tree is empty\n", __func__);
>>>> -             kfree(unittest_data);
>>>> -             return -ENODATA;
>>>> -     }
>>>> -
>>>> -     /*
>>>> -      * This lock normally encloses of_resolve_phandles()
>>>> -      */
>>>> -     of_overlay_mutex_lock();
>>>> -
>>>> -     rc = of_resolve_phandles(unittest_data_node);
>>>> -     if (rc) {
>>>> -             pr_err("%s: Failed to resolve phandles (rc=%i)\n", __func__, rc);
>>>> -             of_overlay_mutex_unlock();
>>>> -             return -EINVAL;
>>>> -     }
>>>> -
>>>> -     if (!of_root) {
>>>> -             of_root = unittest_data_node;
>>>> -             for_each_of_allnodes(np)
>>>> -                     __of_attach_node_sysfs(np);
>>>> -             of_aliases = of_find_node_by_path("/aliases");
>>>> -             of_chosen = of_find_node_by_path("/chosen");
>>>> -             of_overlay_mutex_unlock();
>>>> -             return 0;
>>>> -     }
>>>> +     struct device_node *np;
>>>>
>>>>         EXPECT_BEGIN(KERN_INFO,
>>>>                      "Duplicate name in testcase-data, renamed to \"duplicate-name#1\"");
>>>>
>>>>         /* attach the sub-tree to live tree */
>>>> -     np = unittest_data_node->child;
>>>> +     np = dt->child;
>>>>         while (np) {
>>>>                 struct device_node *next = np->sibling;
>>>>
>>>> @@ -1479,10 +1421,6 @@ static int __init unittest_data_add(void)
>>>>
>>>>         EXPECT_END(KERN_INFO,
>>>>                    "Duplicate name in testcase-data, renamed to \"duplicate-name#1\"");
>>>> -
>>>> -     of_overlay_mutex_unlock();
>>>> -
>>>> -     return 0;
>>>>    }
>>>>
>>>>    #ifdef CONFIG_OF_OVERLAY
>>>> @@ -3258,7 +3196,6 @@ static inline __init void of_unittest_overlay_high_level(void) {}
>>>>    static int __init of_unittest(void)
>>>>    {
>>>>         struct device_node *np;
>>>> -     int res;
>>>>
>>>>         pr_info("start of unittest - you will see error messages\n");
>>>>
>>>> @@ -3267,9 +3204,6 @@ static int __init of_unittest(void)
>>>>         if (IS_ENABLED(CONFIG_UML))
>>>>                 unittest_unflatten_overlay_base();
>>>>
>>>> -     res = unittest_data_add();
>>>> -     if (res)
>>>> -             return res;
>>>>         if (!of_aliases)
>>>>                 of_aliases = of_find_node_by_path("/aliases");
>>>>
>>>> --
>>>> 2.27.0
