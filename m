Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A753463FBC
	for <lists+linux-fpga@lfdr.de>; Tue, 30 Nov 2021 22:15:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240426AbhK3VSr (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 30 Nov 2021 16:18:47 -0500
Received: from mail-mw2nam12on2050.outbound.protection.outlook.com ([40.107.244.50]:14529
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239750AbhK3VSp (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 30 Nov 2021 16:18:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iuj9NML98atxn2dHkPQoFVZNlde4rTNKZl47GL1NksykCM1PU8pPZY9ht8B8Z01+XsapuqLfYkuYktGsL3Drv18lEXqKyYNN03NbikneOhWXPx8gPPHu3UEPzHC6iyeNgbEcn+KrOy290dHoMz0P4uZCEn4lHhCoYgw4l7G7MMjMKNaXYawbH2Kmr2eyqCmcUifExVyCQiT9iWd3OGV9QhZ+Abg/3FOrES71bEUxqYHcH5VJlPUmWhGFxJVDZsgR0tST04EhFTGvuvgELMgGy3mL8QDKOfJe/xv3Wz17PwPQmm9slOXo0iIitfKqTaVlYDOwY6RbWV28A9nhGfxBwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y4a9itjQdnnQ/860RvXVfJvZLU6SRG1BiJOqrx7vFHU=;
 b=MXyiL9fG8rDjqS7WgcC9GrKsicccWnnsPemS2YSHsLofSzMg3vD5B/3u5opPZ5mfgrtyNJIq22t8X0w7iaQxsW/yztfs0Vsh5J6vhZKqtM+QGBYf3Eb+f2SYCl57Ve1P38IYmCI8iOaJXfjpSXAzPZFIOl1fXixi3hIzijSxwUSf4WPuvDzBTnFZQKx0ctvlWDlPQvMVzNSwQ+2ntv4Al+UoNKoh8HTZkIFmxveHvmCovanxaeRbSJKqjfRpYr2X6Z0PcdK59kQKf1WW305H7aPkWkh+3O8fHP7LXRy2lz/l9z8KBilX8/XhsQ3SxxQ2n+K7YC4APzjJHUpD3CBrpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=infradead.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y4a9itjQdnnQ/860RvXVfJvZLU6SRG1BiJOqrx7vFHU=;
 b=DoVODDY98Q0btE8RMgqU8hQQIk2wyl6r1yMwzosAJMgRurSS+B1EfC9yuh41NyUG0rQghm6IJ+6gtAAdhbZ5uZYI1K9U0Ra4E/ER2RPvaFuyKVdEGyd9TIjQ825mDcoHoujrsK//tl4/O8Mdze9SUp5X2+Nmlj3cWBE5EfgnisQ=
Received: from BN9PR03CA0132.namprd03.prod.outlook.com (2603:10b6:408:fe::17)
 by SA0PR02MB7420.namprd02.prod.outlook.com (2603:10b6:806:e9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Tue, 30 Nov
 2021 21:15:23 +0000
Received: from BN1NAM02FT049.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:fe:cafe::5d) by BN9PR03CA0132.outlook.office365.com
 (2603:10b6:408:fe::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend
 Transport; Tue, 30 Nov 2021 21:15:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT049.mail.protection.outlook.com (10.13.2.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Tue, 30 Nov 2021 21:15:22 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 30 Nov 2021 13:15:06 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 30 Nov 2021 13:15:06 -0800
Envelope-to: dwmw2@infradead.org,
 mdf@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 robh@kernel.org
Received: from [10.17.2.60] (port=41108)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1msARe-000Euq-LK; Tue, 30 Nov 2021 13:13:46 -0800
Subject: Re: [PATCH V2 XRT Alveo Infrastructure 3/9] of: handle fdt buffer
 alignment inside unflatten function
To:     Rob Herring <robh@kernel.org>, Lizhi Hou <lizhi.hou@xilinx.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <mdf@kernel.org>,
        <dwmw2@infradead.org>, Max Zhen <max.zhen@xilinx.com>
References: <20211119222412.1092763-1-lizhi.hou@xilinx.com>
 <20211119222412.1092763-4-lizhi.hou@xilinx.com>
 <YaWE/2ikgpXi2hzY@robh.at.kernel.org>
From:   Lizhi Hou <lizhi.hou@xilinx.com>
Message-ID: <e76c91d8-f2a2-f11b-14cb-da554bf42793@xilinx.com>
Date:   Tue, 30 Nov 2021 13:13:46 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <YaWE/2ikgpXi2hzY@robh.at.kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 757014e0-438d-477d-3338-08d9b4468591
X-MS-TrafficTypeDiagnostic: SA0PR02MB7420:
X-Microsoft-Antispam-PRVS: <SA0PR02MB74200332DB7CF8091708336CA1679@SA0PR02MB7420.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mHiIaUCg7+9+9lBThf9h8qSOOOhth7Ng9xOBm6uE1k+VepjIKcbvkSRRELSYsQFKzJ//P1wjkfJ3cVtrv7p0GYVAKv3vbVI+Fzqbmeux81Y0qX2LVmACR1fJETS6B/4oXPZ1gWWEIdbIrXIIqqvqGvdX/1L5mqEpQXktT5WE260rGz0ed22mExOLAOWHgtyet/ouYQa2SUWPrGJlsJii/T1Sk+GrH2gnSZFND7WJtj7N9buCEE6kVn/8IPFlcvmjYqXXrpI8G9OY2FaFag9Z/Olnd+/cv2yjcpzDOz+oJfbGbqRqKDzvJkmkXeru5snTg1+EzZhfzhbO2R1sEbgk2e/FVrt8qY55Fb/LkVhVHG/s57SRKwUQ1u/tYIVcO/RbQeYcr6pW9nNDgxfz19UX5QC8NCqjDaWQVVJHuEYVx6/b6q32fkK6K+BNIqDtDsjonPIQRrIGQ9xreNq8jfYfBA1+N2jnqZs7nb90Y7puj24rpFA8SS+CtlsiLB8Ic0GzZ33BU//VJbuH5hFllywfa777o1KuUn30CwRAYJ7rqNq5SZfQtkLzKUj4nkmtRK1mqwtPd8+XXrwpi282VU0vqlHghsiQvHUQlg7Eyuw8jMkR5mGriN1YKzLICLSBxyRDtXbIrGL26uGR9XPOn5kokH8X9W5yfLQ5Ba35Mjj0ffontfbdsyNtjQg5SaUb5uxvrEaVtNjee7/nSpAnoIBoH26rbBk402cLi2DOGYwoJ4S1jBQ25GEJZ9PqqZNu8OF7
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(36840700001)(46966006)(26005)(70206006)(31696002)(8676002)(508600001)(70586007)(82310400004)(107886003)(4326008)(110136005)(54906003)(316002)(9786002)(2906002)(53546011)(8936002)(36756003)(186003)(83380400001)(5660300002)(2616005)(36860700001)(47076005)(7636003)(336012)(31686004)(356005)(44832011)(426003)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 21:15:22.9825
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 757014e0-438d-477d-3338-08d9b4468591
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT049.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR02MB7420
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 11/29/21 5:57 PM, Rob Herring wrote:
> On Fri, Nov 19, 2021 at 02:24:06PM -0800, Lizhi Hou wrote:
>> Add alignment check to of_fdt_unflatten_tree(). If it is not aligned,
>> allocate a aligned buffer and copy the fdt blob. So the caller does not
>> have to deal with the buffer alignment before calling this function.
>> XRT uses this function to unflatten fdt which is from Alveo firmware.
>>
>> Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
>> Signed-off-by: Max Zhen <max.zhen@xilinx.com>
>> Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
>> ---
>>   drivers/of/fdt.c | 17 ++++++++++++++++-
>>   1 file changed, 16 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
>> index 4546572af24b..d64445e43ceb 100644
>> --- a/drivers/of/fdt.c
>> +++ b/drivers/of/fdt.c
>> @@ -455,13 +455,28 @@ void *of_fdt_unflatten_tree(const unsigned long *blob,
>>                            struct device_node *dad,
>>                            struct device_node **mynodes)
>>   {
>> +     void *new_fdt = NULL, *fdt_align;
>>        void *mem;
>>
>> +     if (fdt_check_header(blob)) {
>> +             pr_err("Invalid fdt blob\n");
>> +             return NULL;
>> +     }
>> +     fdt_align = (void *)PTR_ALIGN(blob, FDT_ALIGN_SIZE);
>> +     if (fdt_align != blob) {
>> +             new_fdt = kmalloc(fdt_totalsize(blob) + FDT_ALIGN_SIZE, GFP_KERNEL);
>> +             if (!new_fdt)
>> +                     return NULL;
>> +             fdt_align = PTR_ALIGN(new_fdt, FDT_ALIGN_SIZE);
> Where's the copy?
>
>> +     }
>> +
>>        mutex_lock(&of_fdt_unflatten_mutex);
>> -     mem = __unflatten_device_tree(blob, dad, mynodes, &kernel_tree_alloc,
>> +     mem = __unflatten_device_tree(fdt_align, dad, mynodes, &kernel_tree_alloc,
>>                                      true);
>>        mutex_unlock(&of_fdt_unflatten_mutex);
>>
>> +     kfree(new_fdt);
> You know the unflattened DT just references strings and property values
> from the flattened DT. So you just caused a use after free.
>
> Fix your firmware to align the DT.

Thanks a lot for pointing this out. I did not aware the direct reference 
of strings and values from the flattened DT. And I will fix this.


Lizhi

>
> Rob
