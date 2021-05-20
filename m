Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E657389B85
	for <lists+linux-fpga@lfdr.de>; Thu, 20 May 2021 04:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbhETCu2 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 19 May 2021 22:50:28 -0400
Received: from mail-mw2nam10on2086.outbound.protection.outlook.com ([40.107.94.86]:56800
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229478AbhETCu2 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 19 May 2021 22:50:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A0qwnGhqdm3o3j86ISwQnNzKdbYiHVfNtEvRly0epd7dMCENDC07HAazqQfUG1YKxseglE6+/1y0iohOx0XCUaIBLvpZBDgqDwI8TE4Aoo+Hy+G+LV7ww/yrIDWCAyaAri0eFUjzjRGICOKXCQ2LOPD8OPaIOi+FwTa71Jae2QkldbK3/cLGTsnM2i4+YCpnqIlDZl7eTGlH0tos7UgxggGbwyK8VVbKP5Hk8TLZgiZL3d3OwLOEKnGGUEYqgNLeB8SMHkPilNdaDyon7Lmh3z8y30szWACwS3fJDOIeAUBoMGAdLq5FyIn/8OmRztvLJl0nBIK0tWkEaHkcUVGCfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kaOTeSh2mo22YDBIwWpmN0P0Aq1bhFkK6qdiwpG1KOQ=;
 b=cxaPU5jF1tlRyBONmbajN/TY0ryJmjAKdnWfTGe5K+hv8IW1ZBNRBb76Y7xgbMacpdURZMDrC4s1/tQ7H3TkTyKICfgpFyKg7KDtsyqI6l4G7ky5wpz3Ugkbh7dpFLbB1X3GlSvlWXahLUEW+59Zr551eG7tjduwTJhLxt+NjDes2mhLgW0L9CH+OKH33tMn7le2wViUPgiyGHma44ghIYMxi8kLPHrzypP1d+uVhfH0Wx697R9cmHzSEQrAxy6OeA1KKVJsOkG3jHTq35IER+lRYuENKtIDB/HoCbeTpYcNisuNOFqHqcCgZ8W5Jzn/joutwA8a7XeZ1bq5h9PR9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kaOTeSh2mo22YDBIwWpmN0P0Aq1bhFkK6qdiwpG1KOQ=;
 b=Y+/NX+3g3MyX2buh7oqe8d8xaNlMu9XRb2GoRDXGBXj5ythojNjHXfS7Mj/xxzS8xkwUcKIbmsDH4ChrTunWZ7lXGdf+WMrWd0RzXL1z3vcd9qmf/oxZHvQHPFt2QpiOePU25YxiGsWGr3BVMlqttSIQe4ldCro4I9u1f0AUGP4=
Received: from BN6PR2001CA0012.namprd20.prod.outlook.com
 (2603:10b6:404:b4::22) by BN0PR02MB8062.namprd02.prod.outlook.com
 (2603:10b6:408:16f::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Thu, 20 May
 2021 02:49:05 +0000
Received: from BN1NAM02FT035.eop-nam02.prod.protection.outlook.com
 (2603:10b6:404:b4:cafe::c9) by BN6PR2001CA0012.outlook.office365.com
 (2603:10b6:404:b4::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25 via Frontend
 Transport; Thu, 20 May 2021 02:49:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT035.mail.protection.outlook.com (10.13.2.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4129.27 via Frontend Transport; Thu, 20 May 2021 02:49:05 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 19 May 2021 19:49:03 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Wed, 19 May 2021 19:49:03 -0700
Envelope-to: robh@kernel.org,
 mdf@kernel.org,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 trix@redhat.com
Received: from [10.17.2.60] (port=56836)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1ljYkB-00012u-Ak; Wed, 19 May 2021 19:49:03 -0700
Subject: Re: [PATCH V6 XRT Alveo 16/20] fpga: xrt: clock driver
To:     Tom Rix <trix@redhat.com>, Lizhi Hou <lizhi.hou@xilinx.com>,
        <linux-kernel@vger.kernel.org>
CC:     <linux-fpga@vger.kernel.org>, <maxz@xilinx.com>,
        <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <mdf@kernel.org>, <robh@kernel.org>,
        Max Zhen <max.zhen@xilinx.com>
References: <20210512015339.5649-1-lizhi.hou@xilinx.com>
 <20210512015339.5649-17-lizhi.hou@xilinx.com>
 <f4a18fa4-f023-d4e5-0622-e15108de90b9@redhat.com>
From:   Lizhi Hou <lizhi.hou@xilinx.com>
Message-ID: <d58eeee5-e47d-4e2b-9b49-15f798c305ed@xilinx.com>
Date:   Wed, 19 May 2021 19:49:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <f4a18fa4-f023-d4e5-0622-e15108de90b9@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0375914d-06a6-4ee5-f974-08d91b39d585
X-MS-TrafficTypeDiagnostic: BN0PR02MB8062:
X-Microsoft-Antispam-PRVS: <BN0PR02MB8062356EDF95FD7D2CE5F8EFA12A9@BN0PR02MB8062.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B33CF9zup5soKF+SI72H8KdWHBnBYeQae4/H9xCioSdTeDVESk4fmTl2U8QPUpdJCtzFCifVKeYWF8I5HUGj2cqYsdL1k9YJcSW2Ew4fmHvbK9599kVLo6afieYsvz8gODQ59JoSbz35y3+LCOcJb7hxVL6GNGZK5DK9OMVBldN2hJwA8na5Na8tSXYr8uLcOp6UpJ8pxqgUPdbgLDI3HYUfJj3PGbKRUGBxuWL+VtxGD5xacR/QnVXtN9+wuIFXavGdiEIr+wpz8tfcI2tS2igx8F9FbPllO3QkpN4+WEsuz0i8aA8ASmLdML2Hqi41f3g+w/T7Di4Bj1CY018/e6h+vdLFVp+45uj0z/FwTG/CnvktgU2lArzejIYoNHLw0klBGbhWeVGjHWlNr8e29Pi7pDtqhQJdPuJMxdrbz3grtnwv+6Jzp7y/xzmCs0X2qp3i1J0sJVbxPEGsU4CrYWpWdZXIhoUvwNXroyAF+3qFXZKmBQn+UL2w6GCJxKL8Xq9DjH9/OPDf02XnY+oxKdbZRLZ4wUBnC1eM/w8GqTf0P/bEt6AVKdmbLMi9xliop+iPd9amgwViartbJpcR0GN1IgtfiZOzprNMGCQaPzBpbDqlfbuoii8PJ83jk7lbPo8ZflHXH+F8F6JEVsKDVp4xOYyvw/GKfZaddo3KJEMKNQV0+YhgzrG4XvfmqvAHqZBwGgUAWCk4+PYyUIRYox/X4NF9ZwCUmInobrF2kW4=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(376002)(136003)(396003)(39860400002)(346002)(46966006)(36840700001)(36906005)(7636003)(478600001)(31696002)(186003)(36756003)(356005)(47076005)(2906002)(8936002)(82740400003)(70586007)(316002)(336012)(5660300002)(70206006)(26005)(110136005)(107886003)(9786002)(54906003)(2616005)(83380400001)(82310400003)(4326008)(53546011)(8676002)(36860700001)(426003)(44832011)(31686004)(50156003)(2101003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2021 02:49:05.7569
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0375914d-06a6-4ee5-f974-08d91b39d585
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT035.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB8062
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 05/13/2021 08:48 AM, Tom Rix wrote:
>
>
>> +
>> +static int get_freq(struct clock *clock, u16 *freq)
>> +{
>
>> +
>> +     /*
>> +      * Multiply both numerator (mul0) and the denominator (div1) with
>> +      * 1000 to account for fractional portion of divider
>> +      */
>> +
>> +     div1 *= 1000;
>> +     div1 += div_frac1;
>> +     div0 *= div1;
>> +     mul0 *= 1000;
>> +     if (div0 == 0) {
>> +             CLOCK_ERR(clock, "clockwiz 0 divider");
>
> This prevents a divide by zero, but returns 0 without setting freq
>
> A -EINVAL should be returned or freq initialized to some default value
Sure.
>
>> +             return 0;
>> +     }
>> +
>> +     input = mul0 * 100;
>> +     do_div(input, div0);
>> +     *freq = (u16)input;
>> +
>> +     return 0;
>> +}
>> +
>>
>> +
>> +static int clock_verify_freq(struct clock *clock)
>> +{
>> +     u32 lookup_freq, clock_freq_counter, request_in_khz, tolerance;
>> +     int err = 0;
>> +     u16 freq;
>> +
>> +     mutex_lock(&clock->clock_lock);
>> +
>> +     err = get_freq(clock, &freq);
>> +     if (err) {
>> +             xrt_err(clock->xdev, "get freq failed, %d", err);
>> +             goto end;
>> +     }
>> +
>> +     err = get_freq_counter(clock, &clock_freq_counter);
>> +     if (err) {
>> +             xrt_err(clock->xdev, "get freq counter failed, %d", err);
>> +             goto end;
>> +     }
>> +
>> +     lookup_freq = find_matching_freq(freq, frequency_table,
>> + ARRAY_SIZE(frequency_table));
>
> I am running v6 through clang's static analyzer, it shows a problem here
>
> drivers/fpga/xrt/lib/xleaf/clock.c:474:16: warning: 1st function call
> argument is an uninitialized value
>         lookup_freq = find_matching_freq(freq, frequency_table,
>                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> See problem with get_freq above
Sure.

Thanks,
Lizhi
>
> Tom
>
>

