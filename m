Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF8CC32ABD8
	for <lists+linux-fpga@lfdr.de>; Tue,  2 Mar 2021 21:52:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344746AbhCBUpL (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 2 Mar 2021 15:45:11 -0500
Received: from mail-co1nam11on2082.outbound.protection.outlook.com ([40.107.220.82]:63968
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1352207AbhCBS3h (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 2 Mar 2021 13:29:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l+0dwuHxK/XTDE3ZE35ZBVITSlr8eVzKzCqOVEDkFPJxuD242isNiiRI3BGz4uE+covUNnYabKGCXagG1nRW0gJf1OtR+8k4bhnaW5wMNCDxZGotGt/Z8CKJJvTc6d0PAOk/uK9GnqVtv2cX+7V5OlIKC12QQCOkiEM0Gab7OW7FQL2w0GSsUXKTeOlNCSSo0SVIQi4I8qKbowIGZrJIxP2L4eV5M1RoCQSUspN1jdkcMn6ShEblIa5zr4yyq4GPatsM+Z9pU1n3B7rg5R4UDn+frVxZ9BwRpfOXe4X25CblkSi8AuuMZ7r9WynSEHpNblIk/YqqKSgaFVCpxLIAAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CQfcpPYHfnddIW1YGScSgIDrcIBlvQpLveHCS8izLxs=;
 b=RgLLboorKIkgd0dYibZyjGnJ35gBT0Sc2NKQ77ASECJTyatHH+I5gi3DsjqLF5+xYVP9TWQZeeZgbFxeYDEoEYDive7rMERZu/QbntMN5a1YHy4vrifjHzAxeByu4xeYRGPtJ7LtQsOD1sbIPFE8qOa7ub5e/h90/NCm//oQBaeI4plhrtDSohiyDP9wAA0PCUvJPboEoVqOKOyd7moE6eh4uq46ulICCM1CF6Ftg9uogZbPM4aRDtnEi83hEVCWIa6bdGMAikgvpZ8l88eJkfVzUG0MCiUNKoAm/kVyoJ8d5J3VEeFgQCwElj1UNfbKQiHmsnFqLRft+uR62Tq44Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CQfcpPYHfnddIW1YGScSgIDrcIBlvQpLveHCS8izLxs=;
 b=OOm3U7BLYUq/SB2iHg8y0SCNI9dxX6SL/vrPNKfe4L9ZVdjuKMSEqRViZWCFkViHtEdjoWuMD1CzKgsxR0WjXZO3DL2t9BR+eHRJsy59wZxxXGass023L4g+NkbRwktlVYDq9LPXtLIWoXIUhnliG/gazD9p9PYKvdrMlNJxyl4=
Received: from CY4PR06CA0062.namprd06.prod.outlook.com (2603:10b6:903:13d::24)
 by MW4PR02MB7378.namprd02.prod.outlook.com (2603:10b6:303:75::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Tue, 2 Mar
 2021 18:26:22 +0000
Received: from CY1NAM02FT063.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:13d:cafe::d6) by CY4PR06CA0062.outlook.office365.com
 (2603:10b6:903:13d::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20 via Frontend
 Transport; Tue, 2 Mar 2021 18:26:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 CY1NAM02FT063.mail.protection.outlook.com (10.152.75.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3890.19 via Frontend Transport; Tue, 2 Mar 2021 18:26:22 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Tue, 2 Mar 2021 10:26:21 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Tue, 2 Mar 2021 10:26:21 -0800
Envelope-to: maxz@xilinx.com,
 max.zhen@xilinx.com,
 michal.simek@xilinx.com,
 sonal.santan@xilinx.com,
 lizhi.hou@xilinx.com,
 stefanos@xilinx.com,
 robh@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 mdf@kernel.org
Received: from [10.17.2.60] (port=50182)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1lH9iv-0003UP-M7; Tue, 02 Mar 2021 10:26:21 -0800
Subject: Re: [PATCH V3 XRT Alveo 12/18] fpga: xrt: ICAP platform driver
To:     Moritz Fischer <mdf@kernel.org>, Lizhi Hou <lizhi.hou@xilinx.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <robh@kernel.org>,
        Max Zhen <max.zhen@xilinx.com>
References: <20210218064019.29189-1-lizhih@xilinx.com>
 <20210218064019.29189-13-lizhih@xilinx.com> <YDLBl2GFjSVcxCUe@archbook>
From:   Lizhi Hou <lizhi.hou@xilinx.com>
Message-ID: <5b305195-6515-59b5-03aa-f2714ad6b181@xilinx.com>
Date:   Tue, 2 Mar 2021 10:26:21 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <YDLBl2GFjSVcxCUe@archbook>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5314c191-b707-4a45-76fd-08d8dda8ae59
X-MS-TrafficTypeDiagnostic: MW4PR02MB7378:
X-Microsoft-Antispam-PRVS: <MW4PR02MB73786388063E6C569ADB1BD8A1999@MW4PR02MB7378.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Za5TLHsxH9eG0pfr+3JZwQoYzL+V03OCm62LBuZhKobSmA2vMn6PWC1IZEfaYlTYC57w6uhwmubchoUd6W037i+0u8ghXAfDFiFSz6DkaR3Y+/k7bnYfGmBlEiIZ3kXnRJnKoCkb4I/bnbV2Hrk6Lf/4Ec5xYFsEyiyIvkUZsU2HhdQa4X+N7no4jPXINy+ueHP/jRC+ditFVaelyKL15t3KJmnnUXcY554BIE5rgB0WUVSiOuTLJBsfZ7rKHzfODWtjSqil4zlo1cznDRVgwYvdTCpMl4GvRRGN5Ay4AQVO3qKmEKFq+aAktaYv/uy5m+9xRUBiDPgjzkRY2tbRVQjrdkpOkNCnY1r6mtkzqDKk15qex7ctgvi9/c/m6IqPf/sGy3a2wfUknZCN61D6vFte548pb+M7T0ZSvixpD++rgRXpEu7CpRFG/Uljqkw69dGC2Qyi54C36s47tU976Cs7Yhv5vOusoFwDinOC3gnpSAGTfqN7GSBS7FpHKPA9rYZMfArHnz8Zp4dFdZibQavnPRVQHTE1K/0A7qtqm8F7vADeplkLA1N2Y8vtiM/c62NRgIgCc5qzICj/2OsDxN96Ib2eliGCJPmWpf/YNNaf3ltnBXCsXAVEul6MEjYG1IPbqJEcn0O3wHp7JunJVoE36ZvkJgPARAWkOUfd1cI3/gs484fFawdfUNlt3bYDr4/Q0st6QiI0FRocRlxcAg==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(39850400004)(136003)(36840700001)(46966006)(70586007)(4326008)(36860700001)(70206006)(44832011)(2616005)(426003)(336012)(53546011)(8676002)(110136005)(9786002)(54906003)(478600001)(83380400001)(316002)(36756003)(356005)(7636003)(5660300002)(82310400003)(2906002)(31696002)(36906005)(82740400003)(107886003)(47076005)(8936002)(30864003)(186003)(26005)(31686004)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2021 18:26:22.1638
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5314c191-b707-4a45-76fd-08d8dda8ae59
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT063.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR02MB7378
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Moritz,



On 02/21/2021 12:24 PM, Moritz Fischer wrote:
> On Wed, Feb 17, 2021 at 10:40:13PM -0800, Lizhi Hou wrote:
>> Add ICAP driver. ICAP is a hardware function discovered by walking
>> firmware metadata. A platform device node will be created for it.
>> FPGA bitstream is written to hardware through ICAP.
>>
>> Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
>> Signed-off-by: Max Zhen <max.zhen@xilinx.com>
>> Signed-off-by: Lizhi Hou <lizhih@xilinx.com>
>> ---
>>   drivers/fpga/xrt/include/xleaf/icap.h |  29 +++
>>   drivers/fpga/xrt/lib/xleaf/icap.c     | 317 ++++++++++++++++++++++++++
>>   2 files changed, 346 insertions(+)
>>   create mode 100644 drivers/fpga/xrt/include/xleaf/icap.h
>>   create mode 100644 drivers/fpga/xrt/lib/xleaf/icap.c
>>
>> diff --git a/drivers/fpga/xrt/include/xleaf/icap.h b/drivers/fpga/xrt/include/xleaf/icap.h
>> new file mode 100644
>> index 000000000000..a14fc0ffa78f
>> --- /dev/null
>> +++ b/drivers/fpga/xrt/include/xleaf/icap.h
>> @@ -0,0 +1,29 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Header file for XRT ICAP Leaf Driver
>> + *
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
>> + * ICAP driver IOCTL calls.
>> + */
>> +enum xrt_icap_ioctl_cmd {
>> +     XRT_ICAP_WRITE = XRT_XLEAF_CUSTOM_BASE, /* See comments in xleaf.h */
>> +     XRT_ICAP_IDCODE,
>> +};
>> +
>> +struct xrt_icap_ioctl_wr {
>> +     void    *xiiw_bit_data;
>> +     u32     xiiw_data_len;
>> +};
>> +
>> +#endif       /* _XRT_ICAP_H_ */
>> diff --git a/drivers/fpga/xrt/lib/xleaf/icap.c b/drivers/fpga/xrt/lib/xleaf/icap.c
>> new file mode 100644
>> index 000000000000..0500a97bdef9
>> --- /dev/null
>> +++ b/drivers/fpga/xrt/lib/xleaf/icap.c
>> @@ -0,0 +1,317 @@
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
> Do we really need two layers of indirection here? What's wrong with
> dev_{info,dbg,...} ?
In case that we would change the massage 'fmt' in the future we can 
change it at one place. And it does not expose any interface or 
introduce performance issue. Could we just keep these Macros?
>> +
>> +/*
>> + * AXI-HWICAP IP register layout
>> + */
>> +struct icap_reg {
>> +     u32     ir_rsvd1[7];
>> +     u32     ir_gier;
>> +     u32     ir_isr;
>> +     u32     ir_rsvd2;
>> +     u32     ir_ier;
>> +     u32     ir_rsvd3[53];
>> +     u32     ir_wf;
>> +     u32     ir_rf;
>> +     u32     ir_sz;
>> +     u32     ir_cr;
>> +     u32     ir_sr;
>> +     u32     ir_wfv;
>> +     u32     ir_rfo;
>> +     u32     ir_asr;
>> +} __packed;
> Can we make those #define and just use writel/readl() ? If you want more
> abstraction, use regmap....
Sure, we will use #define as below and use writel/readl to access them.
       #define ICAP_REG_ISR(base)    ((base) + 0x20)
       ....
>> +
>> +struct icap {
>> +     struct platform_device  *pdev;
>> +     struct icap_reg         *icap_regs;
>> +     struct mutex            icap_lock; /* icap dev lock */
>> +
>> +     unsigned int            idcode;
>> +};
>> +
>> +static inline u32 reg_rd(void __iomem *reg)
>> +{
>> +     if (!reg)
>> +             return -1;
>> +
>> +     return ioread32(reg);
>> +}
>> +
>> +static inline void reg_wr(void __iomem *reg, u32 val)
>> +{
>> +     if (!reg)
>> +             return;
>> +
>> +     iowrite32(val, reg);
>> +}
>> +
>> +static int wait_for_done(struct icap *icap)
>> +{
>> +     u32     w;
>> +     int     i = 0;
>> +
>> +     WARN_ON(!mutex_is_locked(&icap->icap_lock));
>> +     for (i = 0; i < 10; i++) {
>> +             udelay(5);
>> +             w = reg_rd(&icap->icap_regs->ir_sr);
>> +             ICAP_INFO(icap, "XHWICAP_SR: %x", w);
>> +             if (w & 0x5)
>> +                     return 0;
>> +     }
>> +
>> +     ICAP_ERR(icap, "bitstream download timeout");
>> +     return -ETIMEDOUT;
>> +}
>> +
>> +static int icap_write(struct icap *icap, const u32 *word_buf, int size)
>> +{
>> +     int i;
>> +     u32 value = 0;
>> +
>> +     for (i = 0; i < size; i++) {
>> +             value = be32_to_cpu(word_buf[i]);
>> +             reg_wr(&icap->icap_regs->ir_wf, value);
>> +     }
>> +
>> +     reg_wr(&icap->icap_regs->ir_cr, 0x1);
>> +
>> +     for (i = 0; i < 20; i++) {
>> +             value = reg_rd(&icap->icap_regs->ir_cr);
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
>> +     u32 remain_word;
>> +     u32 word_written = 0;
>> +     int wr_fifo_vacancy = 0;
>> +     int err = 0;
>> +
>> +     WARN_ON(!mutex_is_locked(&icap->icap_lock));
>> +     for (remain_word = word_count; remain_word > 0;
>> +             remain_word -= word_written, word_buffer += word_written) {
>> +             wr_fifo_vacancy = reg_rd(&icap->icap_regs->ir_wfv);
>> +             if (wr_fifo_vacancy <= 0) {
>> +                     ICAP_ERR(icap, "no vacancy: %d", wr_fifo_vacancy);
>> +                     err = -EIO;
>> +                     break;
>> +             }
>> +             word_written = (wr_fifo_vacancy < remain_word) ?
>> +                     wr_fifo_vacancy : remain_word;
>> +             if (icap_write(icap, word_buffer, word_written) != 0) {
>> +                     ICAP_ERR(icap, "write failed remain %d, written %d",
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
>> +     u32     num_chars_read = DMA_HWICAP_BITFILE_BUFFER_SIZE;
>> +     u32     byte_read;
>> +     int     err = 0;
>> +
>> +     mutex_lock(&icap->icap_lock);
>> +     for (byte_read = 0; byte_read < length; byte_read += num_chars_read) {
>> +             num_chars_read = length - byte_read;
>> +             if (num_chars_read > DMA_HWICAP_BITFILE_BUFFER_SIZE)
>> +                     num_chars_read = DMA_HWICAP_BITFILE_BUFFER_SIZE;
>> +
>> +             err = bitstream_helper(icap, (u32 *)buffer, num_chars_read / sizeof(u32));
>> +             if (err)
>> +                     goto failed;
>> +             buffer += num_chars_read;
>> +     }
>> +
>> +     err = wait_for_done(icap);
>> +
>> +failed:
>> +     mutex_unlock(&icap->icap_lock);
>> +
>> +     return err;
>> +}
>> +
>> +/*
>> + * Run the following sequence of canned commands to obtain IDCODE of the FPGA
>> + */
>> +static void icap_probe_chip(struct icap *icap)
>> +{
>> +     u32 w;
>> +
>> +     w = reg_rd(&icap->icap_regs->ir_sr);
>> +     w = reg_rd(&icap->icap_regs->ir_sr);
>> +     reg_wr(&icap->icap_regs->ir_gier, 0x0);
>> +     w = reg_rd(&icap->icap_regs->ir_wfv);
>> +     reg_wr(&icap->icap_regs->ir_wf, 0xffffffff);
>> +     reg_wr(&icap->icap_regs->ir_wf, 0xaa995566);
>> +     reg_wr(&icap->icap_regs->ir_wf, 0x20000000);
>> +     reg_wr(&icap->icap_regs->ir_wf, 0x20000000);
>> +     reg_wr(&icap->icap_regs->ir_wf, 0x28018001);
>> +     reg_wr(&icap->icap_regs->ir_wf, 0x20000000);
>> +     reg_wr(&icap->icap_regs->ir_wf, 0x20000000);
>> +     w = reg_rd(&icap->icap_regs->ir_cr);
>> +     reg_wr(&icap->icap_regs->ir_cr, 0x1);
>> +     w = reg_rd(&icap->icap_regs->ir_cr);
>> +     w = reg_rd(&icap->icap_regs->ir_cr);
>> +     w = reg_rd(&icap->icap_regs->ir_sr);
>> +     w = reg_rd(&icap->icap_regs->ir_cr);
>> +     w = reg_rd(&icap->icap_regs->ir_sr);
>> +     reg_wr(&icap->icap_regs->ir_sz, 0x1);
>> +     w = reg_rd(&icap->icap_regs->ir_cr);
>> +     reg_wr(&icap->icap_regs->ir_cr, 0x2);
>> +     w = reg_rd(&icap->icap_regs->ir_rfo);
>> +     icap->idcode = reg_rd(&icap->icap_regs->ir_rf);
>> +     w = reg_rd(&icap->icap_regs->ir_cr);
>> +     (void)w;
> ?!
Right. 'w' does not make sense here. We will remove 'w'.

Thanks,
Lizhi
>> +}
>> +
>> +static int
>> +xrt_icap_leaf_ioctl(struct platform_device *pdev, u32 cmd, void *arg)
>> +{
>> +     struct xrt_icap_ioctl_wr        *wr_arg = arg;
>> +     struct icap                     *icap;
>> +     int                             ret = 0;
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
>> +     case XRT_ICAP_IDCODE:
>> +             *(u64 *)arg = icap->idcode;
>> +             break;
>> +     default:
>> +             ICAP_ERR(icap, "unknown command %d", cmd);
>> +             return -EINVAL;
>> +     }
>> +
>> +     return ret;
>> +}
>> +
>> +static int xrt_icap_remove(struct platform_device *pdev)
>> +{
>> +     struct icap     *icap;
>> +
>> +     icap = platform_get_drvdata(pdev);
>> +
>> +     platform_set_drvdata(pdev, NULL);
>> +     devm_kfree(&pdev->dev, icap);
>> +
>> +     return 0;
>> +}
>> +
>> +static int xrt_icap_probe(struct platform_device *pdev)
>> +{
>> +     struct icap     *icap;
>> +     int                     ret = 0;
>> +     struct resource         *res;
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
>> +     if (res) {
>> +             icap->icap_regs = ioremap(res->start, res->end - res->start + 1);
>> +             if (!icap->icap_regs) {
>> +                     xrt_err(pdev, "map base failed %pR", res);
>> +                     ret = -EIO;
>> +                     goto failed;
>> +             }
>> +     }
>> +
>> +     icap_probe_chip(icap);
>> +failed:
>> +     return ret;
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
>> +             .xsd_ioctl = xrt_icap_leaf_ioctl,
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
>> +     .remove = xrt_icap_remove,
>> +     .id_table = xrt_icap_table,
>> +};
>> +
>> +void icap_leaf_init_fini(bool init)
>> +{
>> +     if (init)
>> +             xleaf_register_driver(XRT_SUBDEV_ICAP, &xrt_icap_driver, xrt_icap_endpoints);
>> +     else
>> +             xleaf_unregister_driver(XRT_SUBDEV_ICAP);
>> +}
>> --
>> 2.18.4
>>
> - Moritz

