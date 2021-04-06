Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD67355F2A
	for <lists+linux-fpga@lfdr.de>; Wed,  7 Apr 2021 01:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232983AbhDFXAY (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 6 Apr 2021 19:00:24 -0400
Received: from mail-dm6nam10on2080.outbound.protection.outlook.com ([40.107.93.80]:62705
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232398AbhDFXAS (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 6 Apr 2021 19:00:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iJu3I61mtuT57RMjRJuwM6fUQO8j2AqQA0e8Ogr3IhwIrSV5op++FF3B5IJa/OgefPkonk/6LadEycIvvGkeoCuWUYbJ8PTWgtQT3s1Vt98pArx9vtgAxiMTLNCzjlHLRp7jbC1IWF9s5ShdKMZKmbFFF5tjFaeywsdAHP+eu3/hGWgzsAPOmYo+jFwnVzxkc0hK4vbQPpqfjBJ4v6G8UGePxT7u00k7BxONre0ssXvxK56IQwDDV2Yntcu3foShU/jsMhRC6bsAVj5aln4rhnFa6f+YSX6ULVe1+MvQ5C70CJ45pWbCetC8j0c9K4Jogns2oUA3eVlLjq7a3SFvBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iGd/xr3Om0j1dHeZFa/FIrzyQ1LDNUmXmhwrhKRzVGA=;
 b=OYcz8AqjbS5Q6t0iVnBJc1oeIeKsq4XmeOH3qFWUPuclC2944iZyp1MCUAT3xYJJptyBNczBA79tC2v+pLKTiZFpUX/fMfU4vdVdB/OsP1XWPeqvPCq/NinvlF1zTNCdVejhaTdlqd5ufsWRsq9MIIBT/q/bS7zKTOtRx34F11ruDLt/7MFPd7vr1aYmg/NpOU8P0NTxFuDL5Cw7aNqQabvchaWENLHuBqCfViMRA0OAhvSqbL56NVpdVvRb1ZZw0qwBEkv5sCPY3z70Ml/nr/GqHja5UAfdfUin1hVuLpaxqbxbgrNKHOPmCskESx+OHNtE6W4eOF/QMiFYB0Gpwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iGd/xr3Om0j1dHeZFa/FIrzyQ1LDNUmXmhwrhKRzVGA=;
 b=fP9nYmEydsc2jj2cnv/9pvaAlW7Zzmy8rgcXtY/ObbP/ydluU9HqHe/gTj8e4V+smJV6HUvdB/a3EHwkMVhzCcnftIpQSlQPXZNNFPx3nkALpVjNHXzKMjoc9gy7Y0V63QX9D/B37d7K8YxlhpfbOeqnzA6IW7awVRxQzslBRI8=
Received: from SN7PR04CA0151.namprd04.prod.outlook.com (2603:10b6:806:125::6)
 by MN2PR02MB7006.namprd02.prod.outlook.com (2603:10b6:208:203::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Tue, 6 Apr
 2021 23:00:06 +0000
Received: from SN1NAM02FT027.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:125:cafe::ee) by SN7PR04CA0151.outlook.office365.com
 (2603:10b6:806:125::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27 via Frontend
 Transport; Tue, 6 Apr 2021 23:00:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT027.mail.protection.outlook.com (10.152.72.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3999.28 via Frontend Transport; Tue, 6 Apr 2021 23:00:06 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 6 Apr 2021 16:00:03 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2106.2 via Frontend Transport; Tue, 6 Apr 2021 16:00:03 -0700
Envelope-to: robh@kernel.org,
 mdf@kernel.org,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 trix@redhat.com
Received: from [10.17.2.60] (port=41328)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1lTufy-0007L5-M0; Tue, 06 Apr 2021 16:00:03 -0700
Subject: Re: [PATCH V4 XRT Alveo 14/20] fpga: xrt: ICAP platform driver
To:     Tom Rix <trix@redhat.com>, Lizhi Hou <lizhi.hou@xilinx.com>,
        <linux-kernel@vger.kernel.org>
CC:     <linux-fpga@vger.kernel.org>, <maxz@xilinx.com>,
        <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <mdf@kernel.org>, <robh@kernel.org>,
        Max Zhen <max.zhen@xilinx.com>
References: <20210324052947.27889-1-lizhi.hou@xilinx.com>
 <20210324052947.27889-15-lizhi.hou@xilinx.com>
 <cff70244-5eb7-7620-da08-2324f3ba26d7@redhat.com>
From:   Lizhi Hou <lizhi.hou@xilinx.com>
Message-ID: <0dfe8532-62d4-d21e-eb39-94d2701caeed@xilinx.com>
Date:   Tue, 6 Apr 2021 16:00:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <cff70244-5eb7-7620-da08-2324f3ba26d7@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 05163d93-f5fe-457a-c34d-08d8f94fb89c
X-MS-TrafficTypeDiagnostic: MN2PR02MB7006:
X-Microsoft-Antispam-PRVS: <MN2PR02MB7006CDCEBD1064FC452C530BA1769@MN2PR02MB7006.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LNMLTyv/SrEWJ/HJSb7Mrnz5QqygpxQabnUFY/6vMn4vfU1zw4t4QmgjsryoOdJFshR8t0GAqzqNqBQkINCAS/+vdZOKkDwGkNuzKP/HS7VxxrkRgYdYLqIA98YVdS9oAx1xzLLXP2PZE02MrmDQTm5c+WdNhSYuaKArt3TSuTCbeUbteTbaf6n5x9l1V9aL4CN4x39MbVlRoBQuHFaZQUN7W65161OHbp7XzUoBttIpxbVLBxnLVWd7C/3cuqbLHsh+Vb77PBYD5KugfRRrOSPCHH24CXqSqI4jKkrytW7KC+N7kOl5jApqHWrASfF5At9ZpJTC4NqCww86AttK0L/WeqLiDjQ0bSNlLvgSNe4ey5GPnK7fk4nlXRaYvpOilM0shpvW2aRHTcpOy4e52O3WCF9JQf8CKRD9U5ANE142WBS9d5TInElrFe5YfcIgp0CgHx/drMpnPoevaDkQ1W8QwoROYP66HiZ62GVLA0nlDOWXY+EklgMFme8PJZO6bCo0r0/d18Uj8lrq/1o/SoHcTFunuAaUR0M/lqRf2VQ9dEYNVkpez9SlZdBwpqdGFSQZd/WRs/WqIbsszit/2jw1w0oDj4n7xIQUUzPDD1nuLHH1x8GlDBG9VkioBwPHrfKjmCY99DZE5VanplyRUbWISNUGPwrfSZ+5q848uUU6n67Da01vJ9/AiqlyQC0Z8yD0KcofrnD3MAAWaYHRxKRpSDhil1o4m0xgxRXVbY52YjwgJ3oqmSosECrOz/3fzimZkIDuE9TvBGaccf46VO7U46MQpFrHQ0USN3c+zRLxzgrmHvTnxcIZiQY/zc9M
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(36906005)(53546011)(54906003)(110136005)(8676002)(36860700001)(26005)(7636003)(31686004)(4326008)(83380400001)(966005)(70206006)(2906002)(107886003)(47076005)(70586007)(498600001)(36756003)(30864003)(9786002)(82310400003)(8936002)(44832011)(2616005)(186003)(336012)(5660300002)(356005)(31696002)(426003)(50156003)(2101003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2021 23:00:06.7050
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05163d93-f5fe-457a-c34d-08d8f94fb89c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT027.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB7006
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Tom,


On 04/06/2021 06:50 AM, Tom Rix wrote:
>
>
> On 3/23/21 10:29 PM, Lizhi Hou wrote:
>> ICAP stands for Hardware Internal Configuration Access Port. ICAP is
>> discovered by walking firmware metadata. A platform device node will be
> by walking the firmware
Sure.
>> created for it. FPGA bitstream is written to hardware through ICAP.
>>
>> Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
>> Signed-off-by: Max Zhen <max.zhen@xilinx.com>
>> Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
>> ---
>>   drivers/fpga/xrt/include/xleaf/icap.h |  27 ++
>>   drivers/fpga/xrt/lib/xleaf/icap.c     | 344 ++++++++++++++++++++++++++
>>   2 files changed, 371 insertions(+)
>>   create mode 100644 drivers/fpga/xrt/include/xleaf/icap.h
>>   create mode 100644 drivers/fpga/xrt/lib/xleaf/icap.c
>>
>> diff --git a/drivers/fpga/xrt/include/xleaf/icap.h 
>> b/drivers/fpga/xrt/include/xleaf/icap.h
>> new file mode 100644
>> index 000000000000..96d39a8934fa
>> --- /dev/null
>> +++ b/drivers/fpga/xrt/include/xleaf/icap.h
>> @@ -0,0 +1,27 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Copyright (C) 2020-2021 Xilinx, Inc.
>> + *
>> + * Authors:
>> + *   Lizhi Hou <Lizhi.Hou@xilinx.com>
>> + */
>> +
>> +#ifndef _XRT_ICAP_H_
>> +#define _XRT_ICAP_H_
>> +
>> +#include "xleaf.h"
>> +
>> +/*
>> + * ICAP driver leaf calls.
>> + */
>> +enum xrt_icap_leaf_cmd {
>> +     XRT_ICAP_WRITE = XRT_XLEAF_CUSTOM_BASE, /* See comments in 
>> xleaf.h */
>> +     XRT_ICAP_GET_IDCODE,
> ok
>> +};
>> +
>> +struct xrt_icap_wr {
>> +     void    *xiiw_bit_data;
>> +     u32     xiiw_data_len;
>> +};
>> +
>> +#endif       /* _XRT_ICAP_H_ */
>> diff --git a/drivers/fpga/xrt/lib/xleaf/icap.c 
>> b/drivers/fpga/xrt/lib/xleaf/icap.c
>> new file mode 100644
>> index 000000000000..13db2b759138
>> --- /dev/null
>> +++ b/drivers/fpga/xrt/lib/xleaf/icap.c
>> @@ -0,0 +1,344 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Xilinx Alveo FPGA ICAP Driver
>> + *
>> + * Copyright (C) 2020-2021 Xilinx, Inc.
>> + *
>> + * Authors:
>> + *      Lizhi Hou<Lizhi.Hou@xilinx.com>
>> + *      Sonal Santan <sonals@xilinx.com>
>> + *      Max Zhen <maxz@xilinx.com>
>> + */
>> +
>> +#include <linux/mod_devicetable.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/delay.h>
>> +#include <linux/device.h>
>> +#include <linux/regmap.h>
>> +#include <linux/io.h>
>> +#include "metadata.h"
>> +#include "xleaf.h"
>> +#include "xleaf/icap.h"
>> +#include "xclbin-helper.h"
>> +
>> +#define XRT_ICAP "xrt_icap"
>> +
>> +#define ICAP_ERR(icap, fmt, arg...)  \
>> +     xrt_err((icap)->pdev, fmt "\n", ##arg)
>> +#define ICAP_WARN(icap, fmt, arg...) \
>> +     xrt_warn((icap)->pdev, fmt "\n", ##arg)
>> +#define ICAP_INFO(icap, fmt, arg...) \
>> +     xrt_info((icap)->pdev, fmt "\n", ##arg)
>> +#define ICAP_DBG(icap, fmt, arg...)  \
>> +     xrt_dbg((icap)->pdev, fmt "\n", ##arg)
>> +
>> +/*
>> + * AXI-HWICAP IP register layout. Please see
>> + * 
>> https://www.xilinx.com/support/documentation/ip_documentation/axi_hwicap/v3_0/pg134-axi-hwicap.pdf
> url works, looks good
>> + */
>> +#define ICAP_REG_GIER                0x1C
>> +#define ICAP_REG_ISR         0x20
>> +#define ICAP_REG_IER         0x28
>> +#define ICAP_REG_WF          0x100
>> +#define ICAP_REG_RF          0x104
>> +#define ICAP_REG_SZ          0x108
>> +#define ICAP_REG_CR          0x10C
>> +#define ICAP_REG_SR          0x110
>> +#define ICAP_REG_WFV         0x114
>> +#define ICAP_REG_RFO         0x118
>> +#define ICAP_REG_ASR         0x11C
>> +
>> +#define ICAP_STATUS_EOS              0x4
>> +#define ICAP_STATUS_DONE     0x1
>> +
>> +/*
>> + * Canned command sequence to obtain IDCODE of the FPGA
>> + */
>> +static const u32 idcode_stream[] = {
>> +     /* dummy word */
>> +     cpu_to_be32(0xffffffff),
>> +     /* sync word */
>> +     cpu_to_be32(0xaa995566),
>> +     /* NOP word */
>> +     cpu_to_be32(0x20000000),
>> +     /* NOP word */
>> +     cpu_to_be32(0x20000000),
>> +     /* ID code */
>> +     cpu_to_be32(0x28018001),
>> +     /* NOP word */
>> +     cpu_to_be32(0x20000000),
>> +     /* NOP word */
>> +     cpu_to_be32(0x20000000),
>> +};
>> +
>> +static const struct regmap_config icap_regmap_config = {
> ok
>> +     .reg_bits = 32,
>> +     .val_bits = 32,
>> +     .reg_stride = 4,
>> +     .max_register = 0x1000,
>> +};
>> +
>> +struct icap {
>> +     struct platform_device  *pdev;
>> +     struct regmap           *regmap;
>> +     struct mutex            icap_lock; /* icap dev lock */
>> +
> whitespace, remove extra nl
Sure.

Thanks,
Lizhi
>> +     u32                     idcode;
>> +};
>> +
>> +static int wait_for_done(const struct icap *icap)
>> +{
>> +     int i = 0;
>> +     int ret;
>> +     u32 w;
>> +
>> +     for (i = 0; i < 10; i++) {
>> +             /*
>> +              * it requires few micro seconds for ICAP to process 
>> incoming data.
>> +              * Polling every 5us for 10 times would be good enough.
> ok
>> +              */
>> +             udelay(5);
>> +             ret = regmap_read(icap->regmap, ICAP_REG_SR, &w);
>> +             if (ret)
>> +                     return ret;
>> +             ICAP_INFO(icap, "XHWICAP_SR: %x", w);
>> +             if (w & (ICAP_STATUS_EOS | ICAP_STATUS_DONE))
> ok
>> +                     return 0;
>> +     }
>> +
>> +     ICAP_ERR(icap, "bitstream download timeout");
>> +     return -ETIMEDOUT;
>> +}
>> +
>> +static int icap_write(const struct icap *icap, const u32 *word_buf, 
>> int size)
>> +{
>> +     u32 value = 0;
>> +     int ret;
>> +     int i;
>> +
>> +     for (i = 0; i < size; i++) {
>> +             value = be32_to_cpu(word_buf[i]);
>> +             ret = regmap_write(icap->regmap, ICAP_REG_WF, value);
>> +             if (ret)
>> +                     return ret;
>> +     }
>> +
>> +     ret = regmap_write(icap->regmap, ICAP_REG_CR, 0x1);
>> +     if (ret)
>> +             return ret;
>> +
>> +     for (i = 0; i < 20; i++) {
>> +             ret = regmap_read(icap->regmap, ICAP_REG_CR, &value);
>> +             if (ret)
>> +                     return ret;
>> +
>> +             if ((value & 0x1) == 0)
>> +                     return 0;
>> +             ndelay(50);
>> +     }
>> +
>> +     ICAP_ERR(icap, "writing %d dwords timeout", size);
>> +     return -EIO;
>> +}
>> +
>> +static int bitstream_helper(struct icap *icap, const u32 *word_buffer,
>> +                         u32 word_count)
>> +{
>> +     int wr_fifo_vacancy = 0;
>> +     u32 word_written = 0;
>> +     u32 remain_word;
>> +     int err = 0;
>> +
>> +     WARN_ON(!mutex_is_locked(&icap->icap_lock));
>> +     for (remain_word = word_count; remain_word > 0;
>> +          remain_word -= word_written, word_buffer += word_written) {
>> +             err = regmap_read(icap->regmap, ICAP_REG_WFV, 
>> &wr_fifo_vacancy);
>> +             if (err) {
>> +                     ICAP_ERR(icap, "read wr_fifo_vacancy failed 
>> %d", err);
>> +                     break;
>> +             }
>> +             if (wr_fifo_vacancy <= 0) {
>> +                     ICAP_ERR(icap, "no vacancy: %d", wr_fifo_vacancy);
>> +                     err = -EIO;
>> +                     break;
>> +             }
>> +             word_written = (wr_fifo_vacancy < remain_word) ?
>> +                     wr_fifo_vacancy : remain_word;
>> +             if (icap_write(icap, word_buffer, word_written) != 0) {
>> +                     ICAP_ERR(icap, "write failed remain %d, written 
>> %d",
>> +                              remain_word, word_written);
>> +                     err = -EIO;
>> +                     break;
>> +             }
>> +     }
>> +
>> +     return err;
>> +}
>> +
>> +static int icap_download(struct icap *icap, const char *buffer,
>> +                      unsigned long length)
>> +{
>> +     u32     num_chars_read = XCLBIN_HWICAP_BITFILE_BUF_SZ;
>> +     u32     byte_read;
>> +     int     err = 0;
>> +
>> +     if (length % sizeof(u32)) {
> ok
>> +             ICAP_ERR(icap, "invalid bitstream length %ld", length);
>> +             return -EINVAL;
>> +     }
>> +
>> +     mutex_lock(&icap->icap_lock);
>> +     for (byte_read = 0; byte_read < length; byte_read += 
>> num_chars_read) {
>> +             num_chars_read = length - byte_read;
>> +             if (num_chars_read > XCLBIN_HWICAP_BITFILE_BUF_SZ)
>> +                     num_chars_read = XCLBIN_HWICAP_BITFILE_BUF_SZ;
>> +
>> +             err = bitstream_helper(icap, (u32 *)buffer, 
>> num_chars_read / sizeof(u32));
>> +             if (err)
>> +                     goto failed;
>> +             buffer += num_chars_read;
>> +     }
>> +
>> +     /* there is not any cleanup needs to be done if writing ICAP 
>> timeout. */
>> +     err = wait_for_done(icap);
>> +
>> +failed:
>> +     mutex_unlock(&icap->icap_lock);
>> +
>> +     return err;
>> +}
>> +
>> +/*
>> + * Discover the FPGA IDCODE using special sequence of canned commands
>> + */
>> +static int icap_probe_chip(struct icap *icap)
>> +{
>> +     int err;
>> +     u32 val = 0;
>
> ok, thanks for demagic-ing this function.
>
> Looks good overall, only a few minor things.
>
> Reviewed-by: Tom Rix <trix@redhat.com>
>
>> +
>> +     regmap_read(icap->regmap, ICAP_REG_SR, &val);
>> +     if (val != ICAP_STATUS_DONE)
>> +             return -ENODEV;
>> +     /* Read ICAP FIFO vacancy */
>> +     regmap_read(icap->regmap, ICAP_REG_WFV, &val);
>> +     if (val < 8)
>> +             return -ENODEV;
>> +     err = icap_write(icap, idcode_stream, ARRAY_SIZE(idcode_stream));
>> +     if (err)
>> +             return err;
>> +     err = wait_for_done(icap);
>> +     if (err)
>> +             return err;
>> +
>> +     /* Tell config engine how many words to transfer to read FIFO */
>> +     regmap_write(icap->regmap, ICAP_REG_SZ, 0x1);
>> +     /* Switch the ICAP to read mode */
>> +     regmap_write(icap->regmap, ICAP_REG_CR, 0x2);
>> +     err = wait_for_done(icap);
>> +     if (err)
>> +             return err;
>> +
>> +     /* Read IDCODE from Read FIFO */
>> +     regmap_read(icap->regmap, ICAP_REG_RF, &icap->idcode);
>> +     return 0;
>> +}
>> +
>> +static int
>> +xrt_icap_leaf_call(struct platform_device *pdev, u32 cmd, void *arg)
>> +{
>> +     struct xrt_icap_wr *wr_arg = arg;
>> +     struct icap *icap;
>> +     int ret = 0;
>> +
>> +     icap = platform_get_drvdata(pdev);
>> +
>> +     switch (cmd) {
>> +     case XRT_XLEAF_EVENT:
>> +             /* Does not handle any event. */
>> +             break;
>> +     case XRT_ICAP_WRITE:
>> +             ret = icap_download(icap, wr_arg->xiiw_bit_data,
>> +                                 wr_arg->xiiw_data_len);
>> +             break;
>> +     case XRT_ICAP_GET_IDCODE:
>> +             *(u32 *)arg = icap->idcode;
>> +             break;
>> +     default:
>> +             ICAP_ERR(icap, "unknown command %d", cmd);
>> +             return -EINVAL;
>> +     }
>> +
>> +     return ret;
>> +}
>> +
>> +static int xrt_icap_probe(struct platform_device *pdev)
>> +{
>> +     void __iomem *base = NULL;
>> +     struct resource *res;
>> +     struct icap *icap;
>> +     int result = 0;
>> +
>> +     icap = devm_kzalloc(&pdev->dev, sizeof(*icap), GFP_KERNEL);
>> +     if (!icap)
>> +             return -ENOMEM;
>> +
>> +     icap->pdev = pdev;
>> +     platform_set_drvdata(pdev, icap);
>> +     mutex_init(&icap->icap_lock);
>> +
>> +     xrt_info(pdev, "probing");
>> +     res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +     if (!res)
>> +             return -EINVAL;
>> +
>> +     base = devm_ioremap_resource(&pdev->dev, res);
>> +     if (IS_ERR(base))
>> +             return PTR_ERR(base);
>> +
>> +     icap->regmap = devm_regmap_init_mmio(&pdev->dev, base, 
>> &icap_regmap_config);
>> +     if (IS_ERR(icap->regmap)) {
>> +             ICAP_ERR(icap, "init mmio failed");
>> +             return PTR_ERR(icap->regmap);
>> +     }
>> +     /* Disable ICAP interrupts */
>> +     regmap_write(icap->regmap, ICAP_REG_GIER, 0);
>> +
>> +     result = icap_probe_chip(icap);
>> +     if (result)
>> +             xrt_err(pdev, "Failed to probe FPGA");
>> +     else
>> +             xrt_info(pdev, "Discovered FPGA IDCODE %x", icap->idcode);
>> +     return result;
>> +}
>> +
>> +static struct xrt_subdev_endpoints xrt_icap_endpoints[] = {
>> +     {
>> +             .xse_names = (struct xrt_subdev_ep_names[]) {
>> +                     { .ep_name = XRT_MD_NODE_FPGA_CONFIG },
>> +                     { NULL },
>> +             },
>> +             .xse_min_ep = 1,
>> +     },
>> +     { 0 },
>> +};
>> +
>> +static struct xrt_subdev_drvdata xrt_icap_data = {
>> +     .xsd_dev_ops = {
>> +             .xsd_leaf_call = xrt_icap_leaf_call,
>> +     },
>> +};
>> +
>> +static const struct platform_device_id xrt_icap_table[] = {
>> +     { XRT_ICAP, (kernel_ulong_t)&xrt_icap_data },
>> +     { },
>> +};
>> +
>> +static struct platform_driver xrt_icap_driver = {
>> +     .driver = {
>> +             .name = XRT_ICAP,
>> +     },
>> +     .probe = xrt_icap_probe,
>> +     .id_table = xrt_icap_table,
>> +};
>> +
>> +XRT_LEAF_INIT_FINI_FUNC(XRT_SUBDEV_ICAP, icap);
>

