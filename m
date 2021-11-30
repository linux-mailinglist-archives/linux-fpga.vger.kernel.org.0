Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19157463FE0
	for <lists+linux-fpga@lfdr.de>; Tue, 30 Nov 2021 22:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344052AbhK3V0J (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 30 Nov 2021 16:26:09 -0500
Received: from mail-bn8nam12on2078.outbound.protection.outlook.com ([40.107.237.78]:5665
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1344020AbhK3VZN (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 30 Nov 2021 16:25:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ILlGKlvSn8EzKYu7f/KzOMjZCrAWgYHKZJFKeRVmVj7jRS869gluCBr8iuvqJ29DVxqPrfKOSO8bJa+2Buayhql0HTQcs/fVxbi7p1oQ8sKua+UeMZDDzU/2/DxW0T9hSXZlyqPoEnh7VNpjmnglbDO2qfrsIjbuDj2KlSaqwH2jd25OpiIIO3cWUwd5XL0JmgRHSvoInOo494ybOLhsgLI5Jo48En38h8vcXsNwEhDGzD1FrkATNtwahsgnH3R0oKsNESFE/mKlUNjr6tQLxKX7AQb/Ve90JXIuCsxxP8pml7UQReD53T8ZZjOczYTey8viIuk/M2CiIqNCmG0BRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ACZI+9CO1Qw3Zjx3l4EyXTAkE82xQM20l6ff+0dHY8=;
 b=NKHcNsKLtR4Yqn9BR4ixB/+ZZwlcGN8VRWh0+WHWIMMihwkFH9vcQ9yJCNUQm94h5ZrJ3LVy1QJJzMTiq6ZfeZUtTa/qhWHn8yZbjV5PbZh+daJqKzqrST5AWHOzcUdpB02hqury0XIGJmxqBVL7CCaZq9tWhDBI2BP+JFG29wfXw6LLj+tdjr60V0anQrpmp/CNpy+1TL+KcDRfCYpBXnNqvrkfwO8WBds3RngkZ2/L0VWw3n1hJ5EcvulVcsIiMvcna9Huvn8OrU1vCeMJe29i8pzRcNKztFF5OtgrKrckJ2fKa+6/rwLRqkpacgSoOtnuuehSX5FNgSesbp5dvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=infradead.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ACZI+9CO1Qw3Zjx3l4EyXTAkE82xQM20l6ff+0dHY8=;
 b=kChz54G5+aDhP3IuBo6KrXE/5So1snfV5LwVcNbKVKw6yFc1HE0vmepTFbXq057ex2Nktb2HiRG04s+FEQXWmL6pkIk9SNbgOenzzpGdg6vkadoYg3gPD4YUVFuNYJ55SnaFzoLRs23Y+Y5uNZNBMZkoeOn2ArO1J8MSEFZWxjE=
Received: from BN9PR03CA0032.namprd03.prod.outlook.com (2603:10b6:408:fb::7)
 by CH2PR02MB6824.namprd02.prod.outlook.com (2603:10b6:610:af::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Tue, 30 Nov
 2021 21:21:52 +0000
Received: from BN1NAM02FT027.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:fb:cafe::a) by BN9PR03CA0032.outlook.office365.com
 (2603:10b6:408:fb::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend
 Transport; Tue, 30 Nov 2021 21:21:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT027.mail.protection.outlook.com (10.13.2.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Tue, 30 Nov 2021 21:21:51 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 30 Nov 2021 13:21:49 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 30 Nov 2021 13:21:49 -0800
Envelope-to: dwmw2@infradead.org,
 mdf@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 robh@kernel.org
Received: from [10.17.2.60] (port=41126)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1msAZR-000Fq4-Bw; Tue, 30 Nov 2021 13:21:49 -0800
Subject: Re: [PATCH V2 XRT Alveo Infrastructure 4/9] of: create empty of root
To:     Rob Herring <robh@kernel.org>, Lizhi Hou <lizhi.hou@xilinx.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <mdf@kernel.org>,
        <dwmw2@infradead.org>, Max Zhen <max.zhen@xilinx.com>
References: <20211119222412.1092763-1-lizhi.hou@xilinx.com>
 <20211119222412.1092763-5-lizhi.hou@xilinx.com>
 <YaWFksVvfQQWqKcG@robh.at.kernel.org>
From:   Lizhi Hou <lizhi.hou@xilinx.com>
Message-ID: <eeeb4657-c936-096e-0cf8-afde2220f626@xilinx.com>
Date:   Tue, 30 Nov 2021 13:21:49 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <YaWFksVvfQQWqKcG@robh.at.kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 628452c4-f1e1-4eac-34d8-08d9b4476d11
X-MS-TrafficTypeDiagnostic: CH2PR02MB6824:
X-Microsoft-Antispam-PRVS: <CH2PR02MB6824D4F52F8EBD0A0E6B2D1BA1679@CH2PR02MB6824.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B+lGtQuYzZcVlHXBexPiOX6ZXnQEzN9TuGoWxB++Xl4EX+4/Ziul19zkqmOQNfiNMEBrBmTJ5Yes1R7YpvlYy618K4aboZ1lfcYSHulbLl2HyEwA5SHsbK6jszmjtPDkmWazR5WwqVoRuxqFUXJuowxESntaXW+mjK+VMwhNidVP6Xn945U3WJcBI3a4zgFoJ6goYyherulA8UN/Emorqt4bmxnMJvuJ4PI9WBD0/j5HCHwm8/NENSRLDGXsaNonAlEf42yB08iU6F293q996VIlVjU6kaSQ2Q74VlTThTMIkHMdAx/HXlV5fYW+PHY6JKaL8nG8pcAR1SbBGYTE+rH5MAXp1PPEA9NuM13IZZR+PK7Z8HPTeihunObDh7YNy49isfKZLgYwlXMDSLvbA5UweV2CnVuv4mI7nWQPZZUcJstYqecKExRtZkQYFLhXEDWpDaxLo5t3BGz/9wrp1VVBpVq3a7uLLyXvNh4RGvFQRjdKo5+6xYDeoMkOorlo9fs9GKdHz5Lg+CKJUqWAVQCFd011ch0Zh0exKFN2gb4dQBPLKF7+st/m5bgr8boF+ECSjlwy5wm/v4PMFpFyIdZ/L00W63DpFuhx7PPw0YD7DqTnyMh6XTAlzF3ImBt/YZlpTC6rMVoCtQpaQ1R/c3+K8MMi4eFQH/kGL5/cxJ8lip7prFEiE+qG1MaW9Oh+k5Q048sMQ01+yfv2ZNGMh2u3lOUjEokx7Vv4P6uRy7u6AcaJte0SdjznqEpuVyat
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(36840700001)(46966006)(5660300002)(4326008)(82310400004)(44832011)(316002)(70586007)(2616005)(110136005)(36756003)(36860700001)(7636003)(54906003)(31686004)(356005)(47076005)(8676002)(107886003)(8936002)(186003)(31696002)(70206006)(9786002)(336012)(53546011)(426003)(83380400001)(508600001)(26005)(2906002)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 21:21:51.3751
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 628452c4-f1e1-4eac-34d8-08d9b4476d11
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT027.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6824
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 11/29/21 5:59 PM, Rob Herring wrote:
> On Fri, Nov 19, 2021 at 02:24:07PM -0800, Lizhi Hou wrote:
>> When OF_FLATTREE is selected and there is not a device tree, create an
>> empty device tree root node. of/unittest.c code is referenced.
> What does the last sentence mean? You copied the code? If so, that's a
> sign you should refactor the unittest code to use this.

I looked into unittest.c for how the of_root is created.  And you are 
right, this could should be unified with unittest.c. I will change it 
with next patch set.

Thanks,

Lizhi

>
>> Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
>> Signed-off-by: Max Zhen <max.zhen@xilinx.com>
>> Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
>> ---
>>   drivers/of/Makefile        |  2 +-
>>   drivers/of/fdt.c           | 20 ++++++++++++++++++++
>>   drivers/of/fdt_default.dts |  5 +++++
>>   drivers/of/of_private.h    |  5 +++++
>>   4 files changed, 31 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/of/fdt_default.dts
>>
>> diff --git a/drivers/of/Makefile b/drivers/of/Makefile
>> index c13b982084a3..815f5220465b 100644
>> --- a/drivers/of/Makefile
>> +++ b/drivers/of/Makefile
>> @@ -2,7 +2,7 @@
>>   obj-y = base.o device.o platform.o property.o
>>   obj-$(CONFIG_OF_KOBJ) += kobj.o
>>   obj-$(CONFIG_OF_DYNAMIC) += dynamic.o
>> -obj-$(CONFIG_OF_FLATTREE) += fdt.o
>> +obj-$(CONFIG_OF_FLATTREE) += fdt.o fdt_default.dtb.o
>>   obj-$(CONFIG_OF_EARLY_FLATTREE) += fdt_address.o
>>   obj-$(CONFIG_OF_PROMTREE) += pdt.o
>>   obj-$(CONFIG_OF_ADDRESS)  += address.o
>> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
>> index d64445e43ceb..3d6e4543419e 100644
>> --- a/drivers/of/fdt.c
>> +++ b/drivers/of/fdt.c
>> @@ -481,6 +481,26 @@ void *of_fdt_unflatten_tree(const unsigned long *blob,
>>   }
>>   EXPORT_SYMBOL_GPL(of_fdt_unflatten_tree);
>>
>> +static int __init of_fdt_root_init(void)
>> +{
>> +     struct device_node *np;
>> +
>> +     if (of_root)
>> +             return 0;
>> +
>> +     if (!of_fdt_unflatten_tree((const unsigned long *)__dtb_fdt_default_begin,
>> +                                NULL, &of_root)) {
>> +             pr_warn("%s: unflatten default tree failed\n", __func__);
>> +             return -ENODATA;
>> +     }
>> +
>> +     for_each_of_allnodes(np)
>> +             __of_attach_node_sysfs(np);
>> +
>> +     return 0;
>> +}
>> +late_initcall(of_fdt_root_init);
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
>> index 631489f7f8c0..47c6bb47ef25 100644
>> --- a/drivers/of/of_private.h
>> +++ b/drivers/of/of_private.h
>> @@ -41,6 +41,11 @@ extern struct mutex of_mutex;
>>   extern struct list_head aliases_lookup;
>>   extern struct kset *of_kset;
>>
>> +#if defined(CONFIG_OF_FLATTREE)
>> +extern u8 __dtb_fdt_default_begin[];
>> +extern u8 __dtb_fdt_default_end[];
>> +#endif
>> +
>>   #if defined(CONFIG_OF_DYNAMIC)
>>   extern int of_property_notify(int action, struct device_node *np,
>>                              struct property *prop, struct property *old_prop);
>> --
>> 2.27.0
>>
>>
