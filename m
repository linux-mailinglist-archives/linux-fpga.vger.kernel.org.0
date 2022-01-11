Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB3BE48A4D6
	for <lists+linux-fpga@lfdr.de>; Tue, 11 Jan 2022 02:14:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346159AbiAKBO0 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 10 Jan 2022 20:14:26 -0500
Received: from mail-dm6nam10on2077.outbound.protection.outlook.com ([40.107.93.77]:14049
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243319AbiAKBOY (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 10 Jan 2022 20:14:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VA5rqOvWCwvcHb6FRbZEg0CPIlTnUZ2NAj4UJbrmYawH7RRZu1MTw6RjZg3ZyRi5kyNiVdguqIKprjAyX9LB7sL9LxHxeYmAsLpNws2Rh3mvTsrMjaiN4Dt7LsXveBUSDoLdi10oIQ4yHUXIuiSLubrMhEGZQYZsCC0plhZfl4Dun68jBh6345q10PXWTD7etXWSmxHe5viVXteEzuf76KOmXBER0SPL3bPf1LSMpDEu5+ybnUIn9HnFgn+zn4pzU5wNdp14w77M6VZKqEFVyfxsX35/rDhpw4ItcYGlLBOtKGt9YF05uFp5lJ9AKqy3mOXG25SWACJPqHrFE3YE0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=twneTeTuYQR3ZelijTPNATtQpwnaEKX+K960b2mzmkI=;
 b=KRgtQlz9zX1MEsExmwStawfWHZh4gZdtOQt442hWZ2F/rXjfCWZtX7DtvsOz1NcjiTW9z72sf/zo2qSHCx8nNtrAlD3tugjzHaZjdrMYKpsXbZO78g8W8nC64Smk3SyXm4tvoBytoSq2efi8MtVria+hmt+q+6c8uvoKSsjIHjN2FW2rxJf/G0iPZCTUPTm6yrJIIwIzUFhq9ctWzm6vNA5GmB9k7SWwUQ0NNpL7SZY57aGrGyy8c0i231jwwYIv0D4dkBvcoCQ5UZKfQQtPyi37uliCTDBl3l43s685LSGd2CqOGcQlnzoBmAbBOGE8JQeQJTZX7gbdyslUJLm30w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=infradead.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=twneTeTuYQR3ZelijTPNATtQpwnaEKX+K960b2mzmkI=;
 b=gM3gTFaOU6wSPxV43Du3zXE2GYKuFr/VsQ21VYYg82F5/JCrl5icg6aK7l/YgoR3bo01eyztHXdUWMBSW22Cs7DDao9APTmFCIRPgAJ7ktnVJIxAB5NzSZx1+IAHIXlSyuvakk5w0h1BuFLFhDw+/KgQdksPIIXqx3WpKQODeiA=
Received: from DM5PR20CA0020.namprd20.prod.outlook.com (2603:10b6:3:93::30) by
 SJ0PR02MB7504.namprd02.prod.outlook.com (2603:10b6:a03:29b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Tue, 11 Jan
 2022 01:14:21 +0000
Received: from DM3NAM02FT045.eop-nam02.prod.protection.outlook.com
 (2603:10b6:3:93:cafe::e) by DM5PR20CA0020.outlook.office365.com
 (2603:10b6:3:93::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7 via Frontend
 Transport; Tue, 11 Jan 2022 01:14:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT045.mail.protection.outlook.com (10.13.4.189) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4867.7 via Frontend Transport; Tue, 11 Jan 2022 01:14:21 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 10 Jan 2022 17:14:20 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 10 Jan 2022 17:14:20 -0800
Envelope-to: dwmw2@infradead.org,
 mdf@kernel.org,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 trix@redhat.com,
 robh@kernel.org
Received: from [10.17.2.60] (port=35392)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1n75jw-0006Iq-CZ; Mon, 10 Jan 2022 17:14:20 -0800
Subject: Re: [PATCH V4 XRT Alveo Infrastructure 3/5] of: create empty of root
To:     <robh@kernel.org>, Tom Rix <trix@redhat.com>,
        Lizhi Hou <lizhi.hou@xilinx.com>,
        <linux-kernel@vger.kernel.org>
CC:     <linux-fpga@vger.kernel.org>, <maxz@xilinx.com>,
        <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <mdf@kernel.org>,
        <dwmw2@infradead.org>, Max Zhen <max.zhen@xilinx.com>
References: <20220105225013.1567871-1-lizhi.hou@xilinx.com>
 <20220105225013.1567871-4-lizhi.hou@xilinx.com>
 <fb65ee24-00e2-dac3-6af8-25f39bcd7a08@redhat.com>
From:   Lizhi Hou <lizhi.hou@xilinx.com>
Message-ID: <fee2a99b-794d-76b5-1a26-131349442130@xilinx.com>
Date:   Mon, 10 Jan 2022 17:14:20 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <fb65ee24-00e2-dac3-6af8-25f39bcd7a08@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e17ba82-f275-4e40-9ac4-08d9d49fb2d1
X-MS-TrafficTypeDiagnostic: SJ0PR02MB7504:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR02MB75042965C250F7446872D786A1519@SJ0PR02MB7504.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yCNOoLiB4msN3SG5NkVcAVdHWH8rAm4+zg6agcjzoXQb9bSvdaZgni1ciZ5DFAG4KlWrUclymZvOxoQEPOfhulDddZuGBGpKJ9DrO5GG4+aDt74v1bHNvpV76woZMkHLxOswoJaMPpYj/NigOL7A6P6CYXHBW8XL3kQ1IgeBwL2WtyvF2M7L9i8nDBjC9yAAWD9Nyh0sRs2hmiBz3xQKjy7nW7yG40ru3UxWtF7kTiuStKQkb1wUX61VcSAqK0zGFMg0pEjAZP4gjKUZH5jJ/t6uLXvc1K6aZDnaeUcmuxmvHxRTok4vG/4plOHd2LKQ2jAQBmSB3Ktykk8PtzhVmJWf5Dp3Z/QbptvjwL1grERNT4ktvFCID5Wwk/uaWipCKzrELuQMw5nINI9v8PoA87hZclS2dND9KkfFZDKSpZlalQDQnOaegxYyGg7Q/5XTWK16Saeaae44g5CdEaVIFYk16lNKZ7Zn2TpdT2vLvkt4d8ca24D2nfFOI9nXl9Eo8mv7kYCCAxYlYihG6dXJ9ZKRTNP0FczN249M69RPd6s+Cfo12+QlIt7k1FNi1YWLSRUqImIZRDkYeu5dOHY0Y2H3hqgfUJO7DzGtSmLPFeuwtSlpcliWbU5E+ojmcMtggVjHeGEejkWcUGcEs+RHq3qFexAl5ZooD2OJTjNumvEwx3M+D0QsyyxUbt/BK+xE9nT0tASdQ2L4/kyyX07kC8nwM+7Ctza/uOaH+0KrT+5lH/oHUdbw9RrPcyb8QiWy8QvvajoigGVUglh1ELmtd4PK4Onk1hGI++4g7kmtAH/PI+0354f4lBzpVPzvASLbK4wPywejCQzJcUcqKlD/RUMcbPlOW3YFO2UCy8qbnkqncBJHxKjHHIrPH9oALSu7X7M+0ukwkvY3xNtUzfYTAw==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(9786002)(186003)(36756003)(5660300002)(31686004)(31696002)(4326008)(110136005)(54906003)(36860700001)(47076005)(8936002)(2616005)(8676002)(966005)(508600001)(26005)(53546011)(70206006)(2906002)(83380400001)(44832011)(426003)(336012)(70586007)(316002)(7636003)(82310400004)(356005)(107886003)(50156003)(43740500002)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 01:14:21.3824
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e17ba82-f275-4e40-9ac4-08d9d49fb2d1
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT045.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7504
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Rob,

We have modified the required device tree change according to your 
latest comments.
https://lore.kernel.org/lkml/YaWE%2F2ikgpXi2hzY@robh.at.kernel.org/
https://lore.kernel.org/lkml/YaWFksVvfQQWqKcG@robh.at.kernel.org/
Waiting for your feedback on the design and code changes.

Tom, thanks for your suggestions. Will incorporate your feedback in the 
next patch series.

Thanks,
Lizhi

On 1/9/22 10:39 AM, Tom Rix wrote:
>
> On 1/5/22 2:50 PM, Lizhi Hou wrote:
>> When OF_FLATTREE is selected and there is not a device tree, create an
>> empty device tree root node. of/unittest.c code is referenced.
>
> Looks like this patch is doing two things, creating the empty node and
> refactoring the unit tests.
>
> This patch should be split.
>
> It is not clear why the unit test should be refactored.
>
> Tom
>
>>
>> Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
>> Signed-off-by: Max Zhen <max.zhen@xilinx.com>
>> Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
>> ---
>>   drivers/of/Makefile        |  5 +++
>>   drivers/of/fdt.c           | 90 ++++++++++++++++++++++++++++++++++++++
>>   drivers/of/fdt_default.dts |  5 +++
>>   drivers/of/of_private.h    | 17 +++++++
>>   drivers/of/unittest.c      | 72 ++----------------------------
>>   5 files changed, 120 insertions(+), 69 deletions(-)
>>   create mode 100644 drivers/of/fdt_default.dts
>>
>> diff --git a/drivers/of/Makefile b/drivers/of/Makefile
>> index c13b982084a3..a2989055c578 100644
>> --- a/drivers/of/Makefile
>> +++ b/drivers/of/Makefile
>> @@ -1,5 +1,6 @@
>>   # SPDX-License-Identifier: GPL-2.0
>>   obj-y = base.o device.o platform.o property.o
>> +
> extra lf, remove
>>   obj-$(CONFIG_OF_KOBJ) += kobj.o
>>   obj-$(CONFIG_OF_DYNAMIC) += dynamic.o
>>   obj-$(CONFIG_OF_FLATTREE) += fdt.o
>> @@ -20,4 +21,8 @@ obj-y       += kexec.o
>>   endif
>>   endif
>>
>> +ifndef CONFIG_OF_UNITTEST
>> +obj-$(CONFIG_OF_FLATTREE) += fdt_default.dtb.o
>> +endif
>> +
>>   obj-$(CONFIG_OF_UNITTEST) += unittest-data/
>> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
>> index 4546572af24b..66ef9ac97829 100644
>> --- a/drivers/of/fdt.c
>> +++ b/drivers/of/fdt.c
>> @@ -466,6 +466,96 @@ void *of_fdt_unflatten_tree(const unsigned long 
>> *blob,
>>   }
>>   EXPORT_SYMBOL_GPL(of_fdt_unflatten_tree);
>>
>> +static int __init of_fdt_root_init(void)
>> +{
>> +     struct device_node *dt = NULL, *np;
>> +     void *fdt = NULL, *fdt_aligned;
>> +     struct property *prop = NULL;
>> +     __be32 *val = NULL;
>> +     int size, rc = 0;
>> +
>> +#if !defined(CONFIG_OF_UNITTEST)
>> +     if (of_root)
>> +             return 0;
>> +#endif
>> +     size = __dtb_fdt_default_end - __dtb_fdt_default_begin;
>> +
>> +     fdt = kmalloc(size + FDT_ALIGN_SIZE, GFP_KERNEL);
>> +     if (!fdt)
>> +             return -ENOMEM;
>> +
>> +     fdt_aligned = PTR_ALIGN(fdt, FDT_ALIGN_SIZE);
>> +     memcpy(fdt_aligned, __dtb_fdt_default_begin, size);
>> +
>> +     if (!of_fdt_unflatten_tree((const unsigned long *)fdt_aligned,
>> +                                NULL, &dt)) {
>> +             pr_warn("%s: unflatten default tree failed\n", __func__);
>> +             kfree(fdt);
>> +             return -ENODATA;
>> +     }
>> +     if (!dt) {
>> +             pr_warn("%s: empty default tree\n", __func__);
>> +             kfree(fdt);
>> +             return -ENODATA;
>> +     }
>> +
>> +     /*
>> +      * This lock normally encloses of_resolve_phandles()
>> +      */
>> +     of_overlay_mutex_lock();
>> +
>> +     rc = of_resolve_phandles(dt);
>> +     if (rc) {
>> +             pr_err("%s: Failed to resolve phandles (rc=%i)\n", 
>> __func__, rc);
>> +             goto failed;
>> +     }
>> +
>> +     if (!of_root) {
>> +             prop = kcalloc(2, sizeof(*prop), GFP_KERNEL);
>> +             if (!prop) {
>> +                     rc = -ENOMEM;
>> +                     goto failed;
>> +             }
>> +             val = kzalloc(sizeof(*val), GFP_KERNEL);
>> +             if (!val) {
>> +                     rc = -ENOMEM;
>> +                     goto failed;
>> +             }
>> +             *val = cpu_to_be32(sizeof(void *) / sizeof(u32));
>> +
>> +             prop->name = "#address-cells";
>> +             prop->value = val;
>> +             prop->length = sizeof(u32);
>> +             of_add_property(dt, prop);
>> +             prop++;
>> +             prop->name = "#size-cells";
>> +             prop->value = val;
>> +             prop->length = sizeof(u32);
>> +             of_add_property(dt, prop);
>> +             of_root = dt;
>> +             for_each_of_allnodes(np)
>> +                     __of_attach_node_sysfs(np);
>> +             of_aliases = of_find_node_by_path("/aliases");
>> +             of_chosen = of_find_node_by_path("/chosen");
>> +             of_overlay_mutex_unlock();
>> +pr_info("OF ROOT FLAG %lx\n", of_root->_flags);
>> +             return 0;
>> +     }
>> +
>> +     unittest_data_add(dt);
>> +
>> +     of_overlay_mutex_unlock();
>> +
>> +     return 0;
>> +
>> +failed:
>> +     of_overlay_mutex_unlock();
>> +     kfree(val);
>> +     kfree(prop);
>> +     return rc;
>> +}
>> +pure_initcall(of_fdt_root_init);
>> +
>>   /* Everything below here references initial_boot_params directly. */
>>   int __initdata dt_root_addr_cells;
>>   int __initdata dt_root_size_cells;
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
>>   extern struct list_head aliases_lookup;
>>   extern struct kset *of_kset;
>>
>> +#if defined(CONFIG_OF_UNITTEST)
>> +extern u8 __dtb_testcases_begin[];
>> +extern u8 __dtb_testcases_end[];
>> +#define __dtb_fdt_default_begin __dtb_testcases_begin
>> +#define __dtb_fdt_default_end __dtb_testcases_end
>> +void __init unittest_data_add(struct device_node *dt);
>> +#else
>> +extern u8 __dtb_fdt_default_begin[];
>> +extern u8 __dtb_fdt_default_end[];
>> +static inline void unittest_data_add(struct device_node *dt) {}
>> +#endif
>> +
>>   #if defined(CONFIG_OF_DYNAMIC)
>>   extern int of_property_notify(int action, struct device_node *np,
>>                             struct property *prop, struct property 
>> *old_prop);
>> @@ -84,6 +96,11 @@ static inline void __of_detach_node_sysfs(struct 
>> device_node *np) {}
>>
>>   #if defined(CONFIG_OF_RESOLVE)
>>   int of_resolve_phandles(struct device_node *tree);
>> +#else
>> +static inline int of_resolve_phandles(struct device_node *tree)
>> +{
>> +     return 0;
>> +}
>>   #endif
>>
>>   void __of_phandle_cache_inv_entry(phandle handle);
>> diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
>> index 8c056972a6dd..745f455235cc 100644
>> --- a/drivers/of/unittest.c
>> +++ b/drivers/of/unittest.c
>> @@ -1402,73 +1402,15 @@ static void attach_node_and_children(struct 
>> device_node *np)
>>    *  unittest_data_add - Reads, copies data from
>>    *  linked tree and attaches it to the live tree
>>    */
>> -static int __init unittest_data_add(void)
>> +void __init unittest_data_add(struct device_node *dt)
>>   {
>> -     void *unittest_data;
>> -     void *unittest_data_align;
>> -     struct device_node *unittest_data_node = NULL, *np;
>> -     /*
>> -      * __dtb_testcases_begin[] and __dtb_testcases_end[] are magically
>> -      * created by cmd_dt_S_dtb in scripts/Makefile.lib
>> -      */
>> -     extern uint8_t __dtb_testcases_begin[];
>> -     extern uint8_t __dtb_testcases_end[];
>> -     const int size = __dtb_testcases_end - __dtb_testcases_begin;
>> -     int rc;
>> -     void *ret;
>> -
>> -     if (!size) {
>> -             pr_warn("%s: testcases is empty\n", __func__);
>> -             return -ENODATA;
>> -     }
>> -
>> -     /* creating copy */
>> -     unittest_data = kmalloc(size + FDT_ALIGN_SIZE, GFP_KERNEL);
>> -     if (!unittest_data)
>> -             return -ENOMEM;
>> -
>> -     unittest_data_align = PTR_ALIGN(unittest_data, FDT_ALIGN_SIZE);
>> -     memcpy(unittest_data_align, __dtb_testcases_begin, size);
>> -
>> -     ret = of_fdt_unflatten_tree(unittest_data_align, NULL, 
>> &unittest_data_node);
>> -     if (!ret) {
>> -             pr_warn("%s: unflatten testcases tree failed\n", 
>> __func__);
>> -             kfree(unittest_data);
>> -             return -ENODATA;
>> -     }
>> -     if (!unittest_data_node) {
>> -             pr_warn("%s: testcases tree is empty\n", __func__);
>> -             kfree(unittest_data);
>> -             return -ENODATA;
>> -     }
>> -
>> -     /*
>> -      * This lock normally encloses of_resolve_phandles()
>> -      */
>> -     of_overlay_mutex_lock();
>> -
>> -     rc = of_resolve_phandles(unittest_data_node);
>> -     if (rc) {
>> -             pr_err("%s: Failed to resolve phandles (rc=%i)\n", 
>> __func__, rc);
>> -             of_overlay_mutex_unlock();
>> -             return -EINVAL;
>> -     }
>> -
>> -     if (!of_root) {
>> -             of_root = unittest_data_node;
>> -             for_each_of_allnodes(np)
>> -                     __of_attach_node_sysfs(np);
>> -             of_aliases = of_find_node_by_path("/aliases");
>> -             of_chosen = of_find_node_by_path("/chosen");
>> -             of_overlay_mutex_unlock();
>> -             return 0;
>> -     }
>> +     struct device_node *np;
>>
>>       EXPECT_BEGIN(KERN_INFO,
>>                    "Duplicate name in testcase-data, renamed to 
>> \"duplicate-name#1\"");
>>
>>       /* attach the sub-tree to live tree */
>> -     np = unittest_data_node->child;
>> +     np = dt->child;
>>       while (np) {
>>               struct device_node *next = np->sibling;
>>
>> @@ -1479,10 +1421,6 @@ static int __init unittest_data_add(void)
>>
>>       EXPECT_END(KERN_INFO,
>>                  "Duplicate name in testcase-data, renamed to 
>> \"duplicate-name#1\"");
>> -
>> -     of_overlay_mutex_unlock();
>> -
>> -     return 0;
>>   }
>>
>>   #ifdef CONFIG_OF_OVERLAY
>> @@ -3258,7 +3196,6 @@ static inline __init void 
>> of_unittest_overlay_high_level(void) {}
>>   static int __init of_unittest(void)
>>   {
>>       struct device_node *np;
>> -     int res;
>>
>>       pr_info("start of unittest - you will see error messages\n");
>>
>> @@ -3267,9 +3204,6 @@ static int __init of_unittest(void)
>>       if (IS_ENABLED(CONFIG_UML))
>>               unittest_unflatten_overlay_base();
>>
>> -     res = unittest_data_add();
>> -     if (res)
>> -             return res;
>>       if (!of_aliases)
>>               of_aliases = of_find_node_by_path("/aliases");
>>
>
