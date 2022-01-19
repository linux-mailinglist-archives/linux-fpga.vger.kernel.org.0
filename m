Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99E55494040
	for <lists+linux-fpga@lfdr.de>; Wed, 19 Jan 2022 20:00:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbiASS77 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 19 Jan 2022 13:59:59 -0500
Received: from mail-dm6nam11on2055.outbound.protection.outlook.com ([40.107.223.55]:50081
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230283AbiASS76 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 19 Jan 2022 13:59:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gM1yEKoYXBpyuTO73LwfsmS6EZqZUngqO4x2rwb3arNlLg1aEdbypetSR1qOySHGDSnmYBctBnCEP2y8gAypX0cnde79UpYsp/awbVAHxcc//I7U3kkwxx44kWgas7TYAcGKdvzNrCSDOePbDfFTCQDz4Tji9zlOT8KzkzpIaofeiyB8f26nRxYJkDWFoNuu/DA8II6K3kYLXaJOkQGsJa5zNWGXoLpPt4r/CV0x+6e9KvHZUk7I3KUEVGCkwlj/a0jXB3luKv81HtMZddVpIFKiFnUoVK7a18cDmTCAciMNw2o4JztlERA9K/05LZ29pClL2xq25lPVZ1Sftcu4hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uiOh/SoEoDRc2OFd6ieX6Srff8W1fmtDScQK7UUABlM=;
 b=kmgPjIutM/iG/+grRCcwTCQf8s1h/2/yWeE+DQL3TaYoJPXQg3DWKB1ojccTgCBfexb00eBKVkk8eDrJVeiDWLEAbR7XtNrhMUVCEwOaUs0uyHBaNBdkobXLh//qMwXhyOyfqeywBZ9Kvg6xanIMGYYD/HOMprFPn2IcY+9sUKVZ4DgHoezyJOJYfxIuDA/wxhbvmKxhK02/gmi/DXQpJQ1ZQM+gSIDJL0KHPJJtuCuHgZPLYOJlcVg2nzp7nMFHYB5tkCrNgSFFrXevUsjkUCzQeC76sRD5qNcwdEcjz+cLgR5kZwnqdzzY7SKVWihkOWZRfVspv9U6LI3SCIV8kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=infradead.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uiOh/SoEoDRc2OFd6ieX6Srff8W1fmtDScQK7UUABlM=;
 b=rub01vZ3lbh0uS2WbGXPD8ET0gRsVpBy8du4g1WvLvnAyiEsdA18dnNnr284TvSh9+xnAoovyO0tzVKMNPjsLvpiF1osXKa28h3dMw0Z42TDzCZQH6rQtRSACebI4AkAie9/eT4FR5foF7Ei0BNapQWPXtOoUGEuIi2uh4GV39c=
Received: from SN7P222CA0011.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:124::32)
 by BY5PR02MB6867.namprd02.prod.outlook.com (2603:10b6:a03:21c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Wed, 19 Jan
 2022 18:59:55 +0000
Received: from SN1NAM02FT0064.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:124:cafe::a) by SN7P222CA0011.outlook.office365.com
 (2603:10b6:806:124::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8 via Frontend
 Transport; Wed, 19 Jan 2022 18:59:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0064.mail.protection.outlook.com (10.97.4.66) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.8 via Frontend Transport; Wed, 19 Jan 2022 18:59:54 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 19 Jan 2022 10:59:48 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 19 Jan 2022 10:59:48 -0800
Envelope-to: dwmw2@infradead.org,
 mdf@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 robh@kernel.org,
 yilun.xu@intel.com
Received: from [10.17.2.60] (port=46160)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1nAGBQ-0006CJ-5l; Wed, 19 Jan 2022 10:59:48 -0800
Subject: Re: [PATCH V4 XRT Alveo Infrastructure 3/5] of: create empty of root
To:     Xu Yilun <yilun.xu@intel.com>, <robh@kernel.org>,
        Lizhi Hou <lizhi.hou@xilinx.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <mdf@kernel.org>,
        <dwmw2@infradead.org>, Max Zhen <max.zhen@xilinx.com>
References: <20220105225013.1567871-1-lizhi.hou@xilinx.com>
 <20220105225013.1567871-4-lizhi.hou@xilinx.com>
 <20220111042920.GA979169@yilunxu-OptiPlex-7050>
From:   Lizhi Hou <lizhi.hou@xilinx.com>
Message-ID: <72a8ee48-b38b-b72c-bcd4-78908af5d829@xilinx.com>
Date:   Wed, 19 Jan 2022 10:59:48 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20220111042920.GA979169@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 24b827b8-62be-4650-4a3b-08d9db7de160
X-MS-TrafficTypeDiagnostic: BY5PR02MB6867:EE_
X-Microsoft-Antispam-PRVS: <BY5PR02MB6867734BA9E29FE8330550D8A1599@BY5PR02MB6867.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5xAcHjpyDC/wv1zDKzcYkbxdJU7VY1rfZxAzsZYEgm59IjARaswULW29tdqNl6RCxxC/i9LZtFf5Wa0Ea4yAcIRMpav2Wr+leIPsqUAPhZeMSKy/AQSgI7eydZbwubeBKFc3Cg/y9Sy5nt9vySUnIOx1ISR1dbIS28mZhwYd0aKrDo0zvsafMP5L2TZOiNOm4GTvAtuS8XpLK/zfTbd2zGjlwGH34UQdCyL9qlE08xezCWzfcCilbNIYMf4O8r6Kjfz80Cop7WmbPT2t6sSuvyHiWtP5qd7FVd8ZtAqxQ10h9bPGZanmp5elSrvYBZZ085elzoyZswz46GFtjywyFZ55LLcMmxVdhifhfF05TXCFut+o/ka00L8imAsFA2cIol+O9O8mSlrcktPObPOPoIEil8Cau+5RZW75TnazZWN8595cFAJt41JpKBYXhrj0ShWr16Th9NIPAlkXSL4b+jWScvCNtc7oylWhhwGStWAPI1XhqBEAaQ0Kyx4lMfsv7/4i08uGvf19oQKmNf10FHaOZ8upBLsVtOAjdh3aWo+h2KcZ6emnDGbIBqPdutrKUM52r2L/rRiapWJE7JhToPLDYa1/Qba5YbV6ubOP6U1Jeq2YbU8eGtC0hcxOwQpA3O9RsAY5dEH9fJP3s1C7N8qguEDqQ+42N0uVx4cGBFTopvia7bvSCMqvgN6VnokCYllwCZ7sdZzLhZqhYlDzkgesounea41i1uZZAQfpcH21xUy9L1Lw53MYUjHEp2tmTj2Nr4MJh7T5rIZd/ap8891gnpcgIT2swP7dGDzirzlXz+xHtKE6fWRLvUmU90coJiediwvClYTocGz6D56p+w==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(26005)(316002)(426003)(5660300002)(31696002)(44832011)(110136005)(53546011)(4326008)(36756003)(186003)(83380400001)(107886003)(36860700001)(336012)(47076005)(356005)(2616005)(30864003)(966005)(31686004)(70586007)(70206006)(82310400004)(508600001)(2906002)(8676002)(7636003)(9786002)(54906003)(8936002)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2022 18:59:54.7433
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24b827b8-62be-4650-4a3b-08d9db7de160
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0064.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6867
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Yilun,

Thanks for your comments. Overall, we made the code change based on 
Rob's comments on previous patch set. Please see my inline comments for 
detail.

Rob, please provide your guidance here.

On 1/10/22 8:29 PM, Xu Yilun wrote:
> On Wed, Jan 05, 2022 at 02:50:11PM -0800, Lizhi Hou wrote:
>> When OF_FLATTREE is selected and there is not a device tree, create an
>> empty device tree root node. of/unittest.c code is referenced.
>>
>> Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
>> Signed-off-by: Max Zhen <max.zhen@xilinx.com>
>> Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
>> ---
>>   drivers/of/Makefile        |  5 +++
>>   drivers/of/fdt.c           | 90 ++++++++++++++++++++++++++++++++++++++
>>   drivers/of/fdt_default.dts |  5 +++
>>   drivers/of/of_private.h    | 17 +++++++
>>   drivers/of/unittest.c      | 72 ++----------------------------
>>   5 files changed, 120 insertions(+), 69 deletions(-)
>>   create mode 100644 drivers/of/fdt_default.dts
>>
>> diff --git a/drivers/of/Makefile b/drivers/of/Makefile
>> index c13b982084a3..a2989055c578 100644
>> --- a/drivers/of/Makefile
>> +++ b/drivers/of/Makefile
>> @@ -1,5 +1,6 @@
>>   # SPDX-License-Identifier: GPL-2.0
>>   obj-y = base.o device.o platform.o property.o
>> +
> remove the blank line.
Will remove.
>
>>   obj-$(CONFIG_OF_KOBJ) += kobj.o
>>   obj-$(CONFIG_OF_DYNAMIC) += dynamic.o
>>   obj-$(CONFIG_OF_FLATTREE) += fdt.o
>> @@ -20,4 +21,8 @@ obj-y       += kexec.o
>>   endif
>>   endif
>>
>> +ifndef CONFIG_OF_UNITTEST
>> +obj-$(CONFIG_OF_FLATTREE) += fdt_default.dtb.o
>> +endif
>> +
> Same question as Tom, the unittest should work well with or without
> of_root, is it? So creating an empty root will not affect unittest, so
> why so many ifdefs for CONFIG_OF_UNITTEST?

Based on Rob's comment in 
https://lore.kernel.org/lkml/YaWFksVvfQQWqKcG@robh.at.kernel.org/, it 
needs to have a unified code to set of_root with or without 
CONFIG_OF_UNITTEST defined.  So the unified code works as this during boot

1. With CONFIG_OF_UNITEST define, of_root is set to base tree 
defined/compiled in testcases.dtb.o

2. Without CONFIG_OF_UNITEST, of_root is set to base tree 
defined/compiled in fdt_default.dtb.o

>
>>   obj-$(CONFIG_OF_UNITTEST) += unittest-data/
>> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
>> index 4546572af24b..66ef9ac97829 100644
>> --- a/drivers/of/fdt.c
>> +++ b/drivers/of/fdt.c
>> @@ -466,6 +466,96 @@ void *of_fdt_unflatten_tree(const unsigned long *blob,
>>   }
>>   EXPORT_SYMBOL_GPL(of_fdt_unflatten_tree);
>>
>> +static int __init of_fdt_root_init(void)
>> +{
>> +     struct device_node *dt = NULL, *np;
>> +     void *fdt = NULL, *fdt_aligned;
>> +     struct property *prop = NULL;
>> +     __be32 *val = NULL;
>> +     int size, rc = 0;
>> +
>> +#if !defined(CONFIG_OF_UNITTEST)
>> +     if (of_root)
>> +             return 0;
>> +#endif
>> +     size = __dtb_fdt_default_end - __dtb_fdt_default_begin;
>> +
>> +     fdt = kmalloc(size + FDT_ALIGN_SIZE, GFP_KERNEL);
>> +     if (!fdt)
>> +             return -ENOMEM;
>> +
>> +     fdt_aligned = PTR_ALIGN(fdt, FDT_ALIGN_SIZE);
>> +     memcpy(fdt_aligned, __dtb_fdt_default_begin, size);
>> +
>> +     if (!of_fdt_unflatten_tree((const unsigned long *)fdt_aligned,
>> +                                NULL, &dt)) {
>> +             pr_warn("%s: unflatten default tree failed\n", __func__);
>> +             kfree(fdt);
>> +             return -ENODATA;
>> +     }
>> +     if (!dt) {
>> +             pr_warn("%s: empty default tree\n", __func__);
>> +             kfree(fdt);
>> +             return -ENODATA;
>> +     }
>> +
>> +     /*
>> +      * This lock normally encloses of_resolve_phandles()
>> +      */
>> +     of_overlay_mutex_lock();
>> +
>> +     rc = of_resolve_phandles(dt);
>> +     if (rc) {
>> +             pr_err("%s: Failed to resolve phandles (rc=%i)\n", __func__, rc);
>> +             goto failed;
>> +     }
>> +
>> +     if (!of_root) {
>> +             prop = kcalloc(2, sizeof(*prop), GFP_KERNEL);
>> +             if (!prop) {
>> +                     rc = -ENOMEM;
>> +                     goto failed;
>> +             }
>> +             val = kzalloc(sizeof(*val), GFP_KERNEL);
>> +             if (!val) {
>> +                     rc = -ENOMEM;
>> +                     goto failed;
>> +             }
>> +             *val = cpu_to_be32(sizeof(void *) / sizeof(u32));
>> +
>> +             prop->name = "#address-cells";
>> +             prop->value = val;
>> +             prop->length = sizeof(u32);
>> +             of_add_property(dt, prop);
>> +             prop++;
>> +             prop->name = "#size-cells";
>> +             prop->value = val;
>> +             prop->length = sizeof(u32);
>> +             of_add_property(dt, prop);
>> +             of_root = dt;
>> +             for_each_of_allnodes(np)
>> +                     __of_attach_node_sysfs(np);
>> +             of_aliases = of_find_node_by_path("/aliases");
>> +             of_chosen = of_find_node_by_path("/chosen");
>> +             of_overlay_mutex_unlock();
>> +pr_info("OF ROOT FLAG %lx\n", of_root->_flags);
>> +             return 0;
>> +     }
>> +
>> +     unittest_data_add(dt);
> It's confusing to me. If we need to share some functions with unittest,
> make a new clearly defined (and named) function.

unittest_data_add() is not shared function. If CONFIG_OF_UNITTEST is not 
defined, this is a null function (please see of_private.h). I just 
followed the existing code style. e.g. of_property_notify() in of_private.h.

Would adding some comments to describe this be good enough?

>
>> +
>> +     of_overlay_mutex_unlock();
>> +
>> +     return 0;
>> +
>> +failed:
>> +     of_overlay_mutex_unlock();
>> +     kfree(val);
>> +     kfree(prop);
>> +     return rc;
>> +}
>> +pure_initcall(of_fdt_root_init);
> Is it better we have a new Kconfig option for the empty tree creation.
Sure, if needed.
>
>> +
>>   /* Everything below here references initial_boot_params directly. */
>>   int __initdata dt_root_addr_cells;
>>   int __initdata dt_root_size_cells;
>> diff --git a/drivers/of/fdt_default.dts b/drivers/of/fdt_default.dts
>> new file mode 100644
>> index 000000000000..d1f12a76dfc6
>> --- /dev/null
>> +++ b/drivers/of/fdt_default.dts
>> @@ -0,0 +1,5 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/dts-v1/;
>> +
>> +/ {
>> +};
>> diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
>> index 631489f7f8c0..1ef93bccfdba 100644
>> --- a/drivers/of/of_private.h
>> +++ b/drivers/of/of_private.h
>> @@ -41,6 +41,18 @@ extern struct mutex of_mutex;
>>   extern struct list_head aliases_lookup;
>>   extern struct kset *of_kset;
>>
>> +#if defined(CONFIG_OF_UNITTEST)
>> +extern u8 __dtb_testcases_begin[];
>> +extern u8 __dtb_testcases_end[];
>> +#define __dtb_fdt_default_begin              __dtb_testcases_begin
>> +#define __dtb_fdt_default_end                __dtb_testcases_end
> Maybe we don't have to use the test dt data, stick to the default empty
> fdt is fine?

I am not sure I understand the point. test dt data contains a lot test 
nodes and we should not create those nodes if CONFIG_OF_UNITTEST is not 
defined.

Are you asking that we create empty of_root here and test nodes are 
created in unittest.c? I believe that was we tried to do with previous 
patch. Is this the same ask within your second comment?

We are open to change it back as previous patch does if needed.

Rob, do you have any comment here?

>
>> +void __init unittest_data_add(struct device_node *dt);
>> +#else
>> +extern u8 __dtb_fdt_default_begin[];
>> +extern u8 __dtb_fdt_default_end[];
>> +static inline void unittest_data_add(struct device_node *dt) {}
>> +#endif
>> +
>>   #if defined(CONFIG_OF_DYNAMIC)
>>   extern int of_property_notify(int action, struct device_node *np,
>>                              struct property *prop, struct property *old_prop);
>> @@ -84,6 +96,11 @@ static inline void __of_detach_node_sysfs(struct device_node *np) {}
>>
>>   #if defined(CONFIG_OF_RESOLVE)
>>   int of_resolve_phandles(struct device_node *tree);
>> +#else
>> +static inline int of_resolve_phandles(struct device_node *tree)
>> +{
>> +     return 0;
>> +}
> If we have an empty of_resolve_phandles, does the empty tree creation
> still works? Or if we don't need this func, just delete in the code.

test nodes creation requires of_resolve_phandles() and creating empty 
of_root does not. This define is added for unifying the code.


Thanks,

Lizhi

>
> Thanks,
> Yilun
>
>>   #endif
>>
>>   void __of_phandle_cache_inv_entry(phandle handle);
>> diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
>> index 8c056972a6dd..745f455235cc 100644
>> --- a/drivers/of/unittest.c
>> +++ b/drivers/of/unittest.c
>> @@ -1402,73 +1402,15 @@ static void attach_node_and_children(struct device_node *np)
>>    *   unittest_data_add - Reads, copies data from
>>    *   linked tree and attaches it to the live tree
>>    */
>> -static int __init unittest_data_add(void)
>> +void __init unittest_data_add(struct device_node *dt)
>>   {
>> -     void *unittest_data;
>> -     void *unittest_data_align;
>> -     struct device_node *unittest_data_node = NULL, *np;
>> -     /*
>> -      * __dtb_testcases_begin[] and __dtb_testcases_end[] are magically
>> -      * created by cmd_dt_S_dtb in scripts/Makefile.lib
>> -      */
>> -     extern uint8_t __dtb_testcases_begin[];
>> -     extern uint8_t __dtb_testcases_end[];
>> -     const int size = __dtb_testcases_end - __dtb_testcases_begin;
>> -     int rc;
>> -     void *ret;
>> -
>> -     if (!size) {
>> -             pr_warn("%s: testcases is empty\n", __func__);
>> -             return -ENODATA;
>> -     }
>> -
>> -     /* creating copy */
>> -     unittest_data = kmalloc(size + FDT_ALIGN_SIZE, GFP_KERNEL);
>> -     if (!unittest_data)
>> -             return -ENOMEM;
>> -
>> -     unittest_data_align = PTR_ALIGN(unittest_data, FDT_ALIGN_SIZE);
>> -     memcpy(unittest_data_align, __dtb_testcases_begin, size);
>> -
>> -     ret = of_fdt_unflatten_tree(unittest_data_align, NULL, &unittest_data_node);
>> -     if (!ret) {
>> -             pr_warn("%s: unflatten testcases tree failed\n", __func__);
>> -             kfree(unittest_data);
>> -             return -ENODATA;
>> -     }
>> -     if (!unittest_data_node) {
>> -             pr_warn("%s: testcases tree is empty\n", __func__);
>> -             kfree(unittest_data);
>> -             return -ENODATA;
>> -     }
>> -
>> -     /*
>> -      * This lock normally encloses of_resolve_phandles()
>> -      */
>> -     of_overlay_mutex_lock();
>> -
>> -     rc = of_resolve_phandles(unittest_data_node);
>> -     if (rc) {
>> -             pr_err("%s: Failed to resolve phandles (rc=%i)\n", __func__, rc);
>> -             of_overlay_mutex_unlock();
>> -             return -EINVAL;
>> -     }
>> -
>> -     if (!of_root) {
>> -             of_root = unittest_data_node;
>> -             for_each_of_allnodes(np)
>> -                     __of_attach_node_sysfs(np);
>> -             of_aliases = of_find_node_by_path("/aliases");
>> -             of_chosen = of_find_node_by_path("/chosen");
>> -             of_overlay_mutex_unlock();
>> -             return 0;
>> -     }
>> +     struct device_node *np;
>>
>>        EXPECT_BEGIN(KERN_INFO,
>>                     "Duplicate name in testcase-data, renamed to \"duplicate-name#1\"");
>>
>>        /* attach the sub-tree to live tree */
>> -     np = unittest_data_node->child;
>> +     np = dt->child;
>>        while (np) {
>>                struct device_node *next = np->sibling;
>>
>> @@ -1479,10 +1421,6 @@ static int __init unittest_data_add(void)
>>
>>        EXPECT_END(KERN_INFO,
>>                   "Duplicate name in testcase-data, renamed to \"duplicate-name#1\"");
>> -
>> -     of_overlay_mutex_unlock();
>> -
>> -     return 0;
>>   }
>>
>>   #ifdef CONFIG_OF_OVERLAY
>> @@ -3258,7 +3196,6 @@ static inline __init void of_unittest_overlay_high_level(void) {}
>>   static int __init of_unittest(void)
>>   {
>>        struct device_node *np;
>> -     int res;
>>
>>        pr_info("start of unittest - you will see error messages\n");
>>
>> @@ -3267,9 +3204,6 @@ static int __init of_unittest(void)
>>        if (IS_ENABLED(CONFIG_UML))
>>                unittest_unflatten_overlay_base();
>>
>> -     res = unittest_data_add();
>> -     if (res)
>> -             return res;
>>        if (!of_aliases)
>>                of_aliases = of_find_node_by_path("/aliases");
>>
>> --
>> 2.27.0
