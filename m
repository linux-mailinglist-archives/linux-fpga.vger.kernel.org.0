Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8A6C33DEC5
	for <lists+linux-fpga@lfdr.de>; Tue, 16 Mar 2021 21:30:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbhCPU3t (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 16 Mar 2021 16:29:49 -0400
Received: from mail-dm6nam10on2048.outbound.protection.outlook.com ([40.107.93.48]:26049
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230486AbhCPU3n (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 16 Mar 2021 16:29:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oSItH9Nrr+DQy4yS/qPQMCQC4mOZjf3+Q7qQjDMFkZ+KIQWIKuCBRc4vjUPmcik2oGtE9yQFlOSmZJij7ctDdDJmqPj1/dKLfPnzIOH65AaSpsbSyh/Yznm9I/Q+i+kMJO7Y/SWEmKlSSKqmIwHKQSddosYqdelcYIrS9568YpcNgmmdcwvVojlu6pxT/k/PZSntVTcO1c9e8oV/85o0xbfIn0FAKiXmkC5CnNjXLQJttobza7l2hMDqc2oVeIrG6RqlPSjjKWWuqndI6kjb4z8zmUuW+9IsfW0E4/lWwzC3cLNHbDS+6y2mOZnT2Rsu4QN+m7F9+G2ZXVGklxB6eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OQGTII9NUQEMbQAD06gHGTgp2uC0ZwT1Nx8y8T5xMWM=;
 b=GO/0pi/Kv2Keb9v0dukZ33Pids+fk2gNJVU43t+uD7Qqbwq/qweGW1f/ixxwxrtDQfuQmyPjcgI9X11A3du+8DZF+ZNw6qAwfvFWnbquIxzEe8MAvI976HUq/XFdUA3qTS93jeNh/EwduGUANAqD3LCZ+5jVVk91Gzvk0cRIQeoNt3zgqK+URF3HitJbJzbFU1fiJ3ZDjWswfkQf50B4mCcoEqVCsjJhBLGbC46ZpEo8HpcqLN3VeCG07+yTtBzOkV3ZC+plJU96+XFV9E1X9AixnT2TcZMzM69fAeDJaHajTxxrn867w8k6SB4cOVcD34smA9mMRpvm+9hq+PSx4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OQGTII9NUQEMbQAD06gHGTgp2uC0ZwT1Nx8y8T5xMWM=;
 b=l1NZDdkfOrlq8siysRGtxTcJufHwe13AhaYs85kalrjt3PsLDB1VtKem2rBjqXzzPGr0XY/yHJEc0/D7q6wwnPt+VvX58ocfNKYVdZ8zy+cgNx1AOrSy0cXwNXvw+mn7CkzGDrraQgAswj4aGDSYkyu+MGH0x57Op/VN+7PpqxQ=
Received: from DM6PR11CA0030.namprd11.prod.outlook.com (2603:10b6:5:190::43)
 by MN2PR02MB6141.namprd02.prod.outlook.com (2603:10b6:208:1ba::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Tue, 16 Mar
 2021 20:29:40 +0000
Received: from DM3NAM02FT064.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:190:cafe::39) by DM6PR11CA0030.outlook.office365.com
 (2603:10b6:5:190::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32 via Frontend
 Transport; Tue, 16 Mar 2021 20:29:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT064.mail.protection.outlook.com (10.13.4.192) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3933.32 via Frontend Transport; Tue, 16 Mar 2021 20:29:40 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 16 Mar 2021 13:29:39 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2106.2 via Frontend Transport; Tue, 16 Mar 2021 13:29:39 -0700
Envelope-to: robh@kernel.org,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 mdf@kernel.org,
 linux-kernel@vger.kernel.org,
 trix@redhat.com
Received: from [10.17.3.3] (port=56470)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <max.zhen@xilinx.com>)
        id 1lMGJv-0005T2-F7; Tue, 16 Mar 2021 13:29:39 -0700
Subject: Re: [PATCH V3 XRT Alveo 07/18] fpga: xrt: management physical
 function driver (root)
To:     Tom Rix <trix@redhat.com>, Lizhi Hou <lizhi.hou@xilinx.com>,
        <linux-kernel@vger.kernel.org>, "mdf@kernel.org" <mdf@kernel.org>
CC:     Lizhi Hou <lizhih@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <sonal.santan@xilinx.com>, <michal.simek@xilinx.com>,
        <stefanos@xilinx.com>, <devicetree@vger.kernel.org>,
        <robh@kernel.org>, Max Zhen <max.zhen@xilinx.com>
References: <20210218064019.29189-1-lizhih@xilinx.com>
 <20210218064019.29189-8-lizhih@xilinx.com>
 <d0057bee-2cf1-b560-c160-636d8e76cbda@redhat.com>
From:   Max Zhen <max.zhen@xilinx.com>
Message-ID: <dd75e8fa-26ed-11a6-a048-7236918fe25b@xilinx.com>
Date:   Tue, 16 Mar 2021 13:29:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <d0057bee-2cf1-b560-c160-636d8e76cbda@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1fcaf4d7-69fc-4b31-9064-08d8e8ba39bf
X-MS-TrafficTypeDiagnostic: MN2PR02MB6141:
X-Microsoft-Antispam-PRVS: <MN2PR02MB6141BA2A2B3B7BC992D57410B96B9@MN2PR02MB6141.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DglwVVynJXHG6wvW9fas2tE7vfQnjVPJkaYLs4fToHtKnhrWurH3lVEaacbPDio6UjTT9XvTGtXVLkhNlmw0HU+D2jsqzXQ3hs/TM97JS737IGwLrffkk1xr1FucCNy0bVln4IuJH+rIVqcdIPiKQu7BL7Y+woIjUB1f1BSR78y98m6PUyUiB0zGuMhF9jDyhu/HlKKUBaATte7unKjFcb7dmQVabfLZxfNIDHOLqvrpPlSSAPMgey/MjUhtoNQ+mOG/ql8ViIBHinQoUqMGLk7q8okNMkSW323+6NxbuHmTD7HwIh3+acFyx80K4jueLGTYBqTigsAbSN9fNwq55Wwg3ECRCTnhBW0TjpAYSDoOc8k9IwHY4nVMkrP3Qay3HMSL/Xm0pj1hL1YbAG5q5melnHyEjyyT6qupk7fVyDooLVP65nKW2i5qi3rQttqy/L0ptVhZrNwKl/PPNI41yNvGdmhiHQV+ingWLv9o3P8JHHyaCUmm3JGg/2Gjv8Zpd3iuc6+TPT6Ucqoljk8BNrVaeAwBEZroIaxfiK/+S7LLAlmhUo9IDe90BFLAbQyWMyyZe0p0smi1rSXeVBQV5gMrx4uM3FogOPRXWaElQWRXpd9O94yq5yRnC8AQKustb3SLgoWbYNtup+7NOqV6WzIy61Um1KxGxePkPdWvSvgcxdHaCspStx+qMZX0JHXK9oVQB9tHSAp1izcgPZv3612QPh9VQX/AvfvS7WnEuIk=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(136003)(39850400004)(396003)(376002)(346002)(46966006)(36840700001)(316002)(26005)(70586007)(2616005)(186003)(70206006)(82740400003)(7636003)(8936002)(336012)(356005)(36860700001)(44832011)(2906002)(82310400003)(83380400001)(47076005)(478600001)(426003)(9786002)(36756003)(54906003)(30864003)(4326008)(8676002)(31696002)(5660300002)(31686004)(107886003)(36906005)(53546011)(110136005)(50156003)(43740500002)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2021 20:29:40.2442
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fcaf4d7-69fc-4b31-9064-08d8e8ba39bf
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT064.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6141
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Tom,


On 2/26/21 7:01 AM, Tom Rix wrote:
> CAUTION: This message has originated from an External Source. Please use proper judgment and caution when opening attachments, clicking links, or responding to this email.
>
>
> A question i do not know the answer to.
>
> Seems like 'golden' is linked to a manufacturing (diagnostics?) image.
>
> If the public will never see it, should handling it here be done ?
>
> Moritz, do you know ?


Golden image is preloaded on the device when it is shipped to customer. 
Then, customer can load other shells (from Xilinx or some other vendor). 
If something goes wrong with the shell, customer can always go back to 
golden and start over again. So, golden image is going to be used in 
public, not just internally by Xilinx.


>
>
> On 2/17/21 10:40 PM, Lizhi Hou wrote:
>> The PCIE device driver which attaches to management function on Alveo
> to the management


Sure.


>> devices. It instantiates one or more partition drivers which in turn
> more fpga partition / group ?


Group driver.


>> instantiate platform drivers. The instantiation of partition and platform
>> drivers is completely data driven.
> data driven ? everything is data driven.  do you mean dtb driven ?


Data driven means not hard-coded. Here data means meta data which is 
presented in device tree format, dtb.


>> Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
>> Signed-off-by: Max Zhen <max.zhen@xilinx.com>
>> Signed-off-by: Lizhi Hou <lizhih@xilinx.com>
>> ---
>>   drivers/fpga/xrt/include/xroot.h | 114 +++++++++++
>>   drivers/fpga/xrt/mgmt/root.c     | 342 +++++++++++++++++++++++++++++++
>>   2 files changed, 456 insertions(+)
>>   create mode 100644 drivers/fpga/xrt/include/xroot.h
>>   create mode 100644 drivers/fpga/xrt/mgmt/root.c
>>
>> diff --git a/drivers/fpga/xrt/include/xroot.h b/drivers/fpga/xrt/include/xroot.h
>> new file mode 100644
>> index 000000000000..752e10daa85e
>> --- /dev/null
>> +++ b/drivers/fpga/xrt/include/xroot.h
>> @@ -0,0 +1,114 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Header file for Xilinx Runtime (XRT) driver
>> + *
>> + * Copyright (C) 2020-2021 Xilinx, Inc.
>> + *
>> + * Authors:
>> + *   Cheng Zhen <maxz@xilinx.com>
>> + */
>> +
>> +#ifndef _XRT_ROOT_H_
>> +#define _XRT_ROOT_H_
>> +
>> +#include <linux/pci.h>
>> +#include "subdev_id.h"
>> +#include "events.h"
>> +
>> +typedef bool (*xrt_subdev_match_t)(enum xrt_subdev_id,
>> +     struct platform_device *, void *);
>> +#define XRT_SUBDEV_MATCH_PREV        ((xrt_subdev_match_t)-1)
>> +#define XRT_SUBDEV_MATCH_NEXT        ((xrt_subdev_match_t)-2)
>> +
>> +/*
>> + * Root IOCTL calls.
>> + */
>> +enum xrt_root_ioctl_cmd {
>> +     /* Leaf actions. */
>> +     XRT_ROOT_GET_LEAF = 0,
>> +     XRT_ROOT_PUT_LEAF,
>> +     XRT_ROOT_GET_LEAF_HOLDERS,
>> +
>> +     /* Group actions. */
>> +     XRT_ROOT_CREATE_GROUP,
>> +     XRT_ROOT_REMOVE_GROUP,
>> +     XRT_ROOT_LOOKUP_GROUP,
>> +     XRT_ROOT_WAIT_GROUP_BRINGUP,
>> +
>> +     /* Event actions. */
>> +     XRT_ROOT_EVENT,
> should this be XRT_ROOT_EVENT_SYNC ?


Sure.


>> +     XRT_ROOT_EVENT_ASYNC,
>> +
>> +     /* Device info. */
>> +     XRT_ROOT_GET_RESOURCE,
>> +     XRT_ROOT_GET_ID,
>> +
>> +     /* Misc. */
>> +     XRT_ROOT_HOT_RESET,
>> +     XRT_ROOT_HWMON,
>> +};
>> +
>> +struct xrt_root_ioctl_get_leaf {
>> +     struct platform_device *xpigl_pdev; /* caller's pdev */
> xpigl_ ? unneeded suffix in element names


It's needed since the it might be included and used in > 1 .c files. I'd 
like to keep it's name unique.


>> +     xrt_subdev_match_t xpigl_match_cb;
>> +     void *xpigl_match_arg;
>> +     struct platform_device *xpigl_leaf; /* target leaf pdev */
>> +};
>> +
>> +struct xrt_root_ioctl_put_leaf {
>> +     struct platform_device *xpipl_pdev; /* caller's pdev */
>> +     struct platform_device *xpipl_leaf; /* target's pdev */
> caller_pdev;
>
> target_pdev;


Sure.


>
>> +};
>> +
>> +struct xrt_root_ioctl_lookup_group {
>> +     struct platform_device *xpilp_pdev; /* caller's pdev */
>> +     xrt_subdev_match_t xpilp_match_cb;
>> +     void *xpilp_match_arg;
>> +     int xpilp_grp_inst;
>> +};
>> +
>> +struct xrt_root_ioctl_get_holders {
>> +     struct platform_device *xpigh_pdev; /* caller's pdev */
>> +     char *xpigh_holder_buf;
>> +     size_t xpigh_holder_buf_len;
>> +};
>> +
>> +struct xrt_root_ioctl_get_res {
>> +     struct resource *xpigr_res;
>> +};
>> +
>> +struct xrt_root_ioctl_get_id {
>> +     unsigned short  xpigi_vendor_id;
>> +     unsigned short  xpigi_device_id;
>> +     unsigned short  xpigi_sub_vendor_id;
>> +     unsigned short  xpigi_sub_device_id;
>> +};
>> +
>> +struct xrt_root_ioctl_hwmon {
>> +     bool xpih_register;
>> +     const char *xpih_name;
>> +     void *xpih_drvdata;
>> +     const struct attribute_group **xpih_groups;
>> +     struct device *xpih_hwmon_dev;
>> +};
>> +
>> +typedef int (*xrt_subdev_root_cb_t)(struct device *, void *, u32, void *);
> This function pointer type is important, please add a comment about its use and expected parameters


Added.


>> +int xrt_subdev_root_request(struct platform_device *self, u32 cmd, void *arg);
>> +
>> +/*
>> + * Defines physical function (MPF / UPF) specific operations
>> + * needed in common root driver.
>> + */
>> +struct xroot_pf_cb {
>> +     void (*xpc_hot_reset)(struct pci_dev *pdev);
> This is only ever set to xmgmt_root_hot_reset, why is this abstraction needed ?


As comment says, hot reset is implemented differently in MPF and UPF 
driver. So, we need this callback in this common code. Note that we have 
not added UPF code in our initial patch yet. It will be added in the future.


>> +};
>> +
>> +int xroot_probe(struct pci_dev *pdev, struct xroot_pf_cb *cb, void **root);
>> +void xroot_remove(void *root);
>> +bool xroot_wait_for_bringup(void *root);
>> +int xroot_add_vsec_node(void *root, char *dtb);
>> +int xroot_create_group(void *xr, char *dtb);
>> +int xroot_add_simple_node(void *root, char *dtb, const char *endpoint);
>> +void xroot_broadcast(void *root, enum xrt_events evt);
>> +
>> +#endif       /* _XRT_ROOT_H_ */
>> diff --git a/drivers/fpga/xrt/mgmt/root.c b/drivers/fpga/xrt/mgmt/root.c
>> new file mode 100644
>> index 000000000000..583a37c9d30c
>> --- /dev/null
>> +++ b/drivers/fpga/xrt/mgmt/root.c
>> @@ -0,0 +1,342 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Xilinx Alveo Management Function Driver
>> + *
>> + * Copyright (C) 2020-2021 Xilinx, Inc.
>> + *
>> + * Authors:
>> + *   Cheng Zhen <maxz@xilinx.com>
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/pci.h>
>> +#include <linux/aer.h>
>> +#include <linux/vmalloc.h>
>> +#include <linux/delay.h>
>> +
>> +#include "xroot.h"
>> +#include "main-impl.h"
>> +#include "metadata.h"
>> +
>> +#define XMGMT_MODULE_NAME    "xmgmt"
> The xrt modules would be more easily identified with a 'xrt' prefix instead of 'x'


We will change the module name to xrt-mgmt.


>> +#define XMGMT_DRIVER_VERSION "4.0.0"
>> +
>> +#define XMGMT_PDEV(xm)               ((xm)->pdev)
>> +#define XMGMT_DEV(xm)                (&(XMGMT_PDEV(xm)->dev))
>> +#define xmgmt_err(xm, fmt, args...)  \
>> +     dev_err(XMGMT_DEV(xm), "%s: " fmt, __func__, ##args)
>> +#define xmgmt_warn(xm, fmt, args...) \
>> +     dev_warn(XMGMT_DEV(xm), "%s: " fmt, __func__, ##args)
>> +#define xmgmt_info(xm, fmt, args...) \
>> +     dev_info(XMGMT_DEV(xm), "%s: " fmt, __func__, ##args)
>> +#define xmgmt_dbg(xm, fmt, args...)  \
>> +     dev_dbg(XMGMT_DEV(xm), "%s: " fmt, __func__, ##args)
>> +#define XMGMT_DEV_ID(_pcidev)                        \
>> +     ({ typeof(_pcidev) (pcidev) = (_pcidev);        \
>> +     ((pci_domain_nr((pcidev)->bus) << 16) | \
>> +     PCI_DEVID((pcidev)->bus->number, 0)); })
>> +
>> +static struct class *xmgmt_class;
>> +static const struct pci_device_id xmgmt_pci_ids[] = {
>> +     { PCI_DEVICE(0x10EE, 0xd020), }, /* Alveo U50 (golden image) */
>> +     { PCI_DEVICE(0x10EE, 0x5020), }, /* Alveo U50 */
> demagic this table, look at dfl-pci for how to use existing #define for the vendor and create a new on for the device.  If there are vf's add them at the same time.
>
> What is a golden image ?


Fixed. Please see my comments above for golden image.


>
>> +     { 0, }
>> +};
>> +
>> +struct xmgmt {
>> +     struct pci_dev *pdev;
>> +     void *root;
>> +
>> +     bool ready;
>> +};
>> +
>> +static int xmgmt_config_pci(struct xmgmt *xm)
>> +{
>> +     struct pci_dev *pdev = XMGMT_PDEV(xm);
>> +     int rc;
>> +
>> +     rc = pcim_enable_device(pdev);
>> +     if (rc < 0) {
>> +             xmgmt_err(xm, "failed to enable device: %d", rc);
>> +             return rc;
>> +     }
>> +
>> +     rc = pci_enable_pcie_error_reporting(pdev);
>> +     if (rc)
>> +             xmgmt_warn(xm, "failed to enable AER: %d", rc);
>> +
>> +     pci_set_master(pdev);
>> +
>> +     rc = pcie_get_readrq(pdev);
> Review this call, it does not go negative


I'll remove the check against negative value.


>> +     if (rc < 0) {
>> +             xmgmt_err(xm, "failed to read mrrs %d", rc);
>> +             return rc;
>> +     }
> this is a quirk, add a comment.


Will remove.


>> +     if (rc > 512) {
>> +             rc = pcie_set_readrq(pdev, 512);
>> +             if (rc) {
>> +                     xmgmt_err(xm, "failed to force mrrs %d", rc);
> similar calls do not fail here.


Will remove.


>> +                     return rc;
>> +             }
>> +     }
>> +
>> +     return 0;
>> +}
>> +
>> +static int xmgmt_match_slot_and_save(struct device *dev, void *data)
>> +{
>> +     struct xmgmt *xm = data;
>> +     struct pci_dev *pdev = to_pci_dev(dev);
>> +
>> +     if (XMGMT_DEV_ID(pdev) == XMGMT_DEV_ID(xm->pdev)) {
>> +             pci_cfg_access_lock(pdev);
>> +             pci_save_state(pdev);
>> +     }
>> +
>> +     return 0;
>> +}
>> +
>> +static void xmgmt_pci_save_config_all(struct xmgmt *xm)
>> +{
>> +     bus_for_each_dev(&pci_bus_type, NULL, xm, xmgmt_match_slot_and_save);
> This is a bus call, not a device call.
>
> Can this be changed into something like what hot reset does ?


We are working on both mgmt pf and user pf here, so sort of like a bus. 
But, it might be better to refactor this when we have our own bus type 
implementation. We do not need to make PCIE bus call. We will fix this 
in V5 patch set where we'll implement our own bus type.


>
>> +}
>> +
>> +static int xmgmt_match_slot_and_restore(struct device *dev, void *data)
>> +{
>> +     struct xmgmt *xm = data;
>> +     struct pci_dev *pdev = to_pci_dev(dev);
>> +
>> +     if (XMGMT_DEV_ID(pdev) == XMGMT_DEV_ID(xm->pdev)) {
>> +             pci_restore_state(pdev);
>> +             pci_cfg_access_unlock(pdev);
>> +     }
>> +
>> +     return 0;
>> +}
>> +
>> +static void xmgmt_pci_restore_config_all(struct xmgmt *xm)
>> +{
>> +     bus_for_each_dev(&pci_bus_type, NULL, xm, xmgmt_match_slot_and_restore);
>> +}
>> +
>> +static void xmgmt_root_hot_reset(struct pci_dev *pdev)
>> +{
>> +     struct xmgmt *xm = pci_get_drvdata(pdev);
>> +     struct pci_bus *bus;
>> +     u8 pci_bctl;
>> +     u16 pci_cmd, devctl;
>> +     int i, ret;
>> +
>> +     xmgmt_info(xm, "hot reset start");
>> +
>> +     xmgmt_pci_save_config_all(xm);
>> +
>> +     pci_disable_device(pdev);
>> +
>> +     bus = pdev->bus;
>> +
>> +     /*
>> +      * When flipping the SBR bit, device can fall off the bus. This is
>> +      * usually no problem at all so long as drivers are working properly
>> +      * after SBR. However, some systems complain bitterly when the device
>> +      * falls off the bus.
>> +      * The quick solution is to temporarily disable the SERR reporting of
>> +      * switch port during SBR.
>> +      */
>> +
>> +     pci_read_config_word(bus->self, PCI_COMMAND, &pci_cmd);
>> +     pci_write_config_word(bus->self, PCI_COMMAND,
>> +                           (pci_cmd & ~PCI_COMMAND_SERR));
>> +     pcie_capability_read_word(bus->self, PCI_EXP_DEVCTL, &devctl);
>> +     pcie_capability_write_word(bus->self, PCI_EXP_DEVCTL,
>> +                                (devctl & ~PCI_EXP_DEVCTL_FERE));
>> +     pci_read_config_byte(bus->self, PCI_BRIDGE_CONTROL, &pci_bctl);
>> +     pci_bctl |= PCI_BRIDGE_CTL_BUS_RESET;
>> +     pci_write_config_byte(bus->self, PCI_BRIDGE_CONTROL, pci_bctl);
> how the pci config values are set and cleared should be consistent.
>
> this call should be
>
> pci_write_config_byte (... pci_bctl | PCI_BRIDGE_CTL_BUF_RESET )
>
> and the next &= avoided


Sure.


>
>> +
>> +     msleep(100);
>> +     pci_bctl &= ~PCI_BRIDGE_CTL_BUS_RESET;
>> +     pci_write_config_byte(bus->self, PCI_BRIDGE_CONTROL, pci_bctl);
>> +     ssleep(1);
>> +
>> +     pcie_capability_write_word(bus->self, PCI_EXP_DEVCTL, devctl);
>> +     pci_write_config_word(bus->self, PCI_COMMAND, pci_cmd);
>> +
>> +     ret = pci_enable_device(pdev);
>> +     if (ret)
>> +             xmgmt_err(xm, "failed to enable device, ret %d", ret);
>> +
>> +     for (i = 0; i < 300; i++) {
>> +             pci_read_config_word(pdev, PCI_COMMAND, &pci_cmd);
>> +             if (pci_cmd != 0xffff)
> what happens with i == 300 and pci_cmd is still 0xffff ?


Something wrong happens to the device since it's not coming back after 
the reset. In this case, the device cannot be used and the only way to 
recover is to power cycle the system so that the shell can be reloaded 
from the flash on the device.


>> +                     break;
>> +             msleep(20);
>> +     }
>> +
>> +     xmgmt_info(xm, "waiting for %d ms", i * 20);
>> +     xmgmt_pci_restore_config_all(xm);
>> +     xmgmt_config_pci(xm);
>> +}
>> +
>> +static int xmgmt_create_root_metadata(struct xmgmt *xm, char **root_dtb)
>> +{
>> +     char *dtb = NULL;
>> +     int ret;
>> +
>> +     ret = xrt_md_create(XMGMT_DEV(xm), &dtb);
>> +     if (ret) {
>> +             xmgmt_err(xm, "create metadata failed, ret %d", ret);
>> +             goto failed;
>> +     }
>> +
>> +     ret = xroot_add_vsec_node(xm->root, dtb);
>> +     if (ret == -ENOENT) {
>> +             /*
>> +              * We may be dealing with a MFG board.
>> +              * Try vsec-golden which will bring up all hard-coded leaves
>> +              * at hard-coded offsets.
>> +              */
>> +             ret = xroot_add_simple_node(xm->root, dtb, XRT_MD_NODE_VSEC_GOLDEN);
> Manufacturing diagnostics ?


This is for golden image support. Please see my comments above.


Thanks,

Max

>
> Tom
>
>> +     } else if (ret == 0) {
>> +             ret = xroot_add_simple_node(xm->root, dtb, XRT_MD_NODE_MGMT_MAIN);
>> +     }
>> +     if (ret)
>> +             goto failed;
>> +
>> +     *root_dtb = dtb;
>> +     return 0;
>> +
>> +failed:
>> +     vfree(dtb);
>> +     return ret;
>> +}
>> +
>> +static ssize_t ready_show(struct device *dev,
>> +                       struct device_attribute *da,
>> +                       char *buf)
>> +{
>> +     struct pci_dev *pdev = to_pci_dev(dev);
>> +     struct xmgmt *xm = pci_get_drvdata(pdev);
>> +
>> +     return sprintf(buf, "%d\n", xm->ready);
>> +}
>> +static DEVICE_ATTR_RO(ready);
>> +
>> +static struct attribute *xmgmt_root_attrs[] = {
>> +     &dev_attr_ready.attr,
>> +     NULL
>> +};
>> +
>> +static struct attribute_group xmgmt_root_attr_group = {
>> +     .attrs = xmgmt_root_attrs,
>> +};
>> +
>> +static struct xroot_pf_cb xmgmt_xroot_pf_cb = {
>> +     .xpc_hot_reset = xmgmt_root_hot_reset,
>> +};
>> +
>> +static int xmgmt_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>> +{
>> +     int ret;
>> +     struct device *dev = &pdev->dev;
>> +     struct xmgmt *xm = devm_kzalloc(dev, sizeof(*xm), GFP_KERNEL);
>> +     char *dtb = NULL;
>> +
>> +     if (!xm)
>> +             return -ENOMEM;
>> +     xm->pdev = pdev;
>> +     pci_set_drvdata(pdev, xm);
>> +
>> +     ret = xmgmt_config_pci(xm);
>> +     if (ret)
>> +             goto failed;
>> +
>> +     ret = xroot_probe(pdev, &xmgmt_xroot_pf_cb, &xm->root);
>> +     if (ret)
>> +             goto failed;
>> +
>> +     ret = xmgmt_create_root_metadata(xm, &dtb);
>> +     if (ret)
>> +             goto failed_metadata;
>> +
>> +     ret = xroot_create_group(xm->root, dtb);
>> +     vfree(dtb);
>> +     if (ret)
>> +             xmgmt_err(xm, "failed to create root group: %d", ret);
>> +
>> +     if (!xroot_wait_for_bringup(xm->root))
>> +             xmgmt_err(xm, "failed to bringup all groups");
>> +     else
>> +             xm->ready = true;
>> +
>> +     ret = sysfs_create_group(&pdev->dev.kobj, &xmgmt_root_attr_group);
>> +     if (ret) {
>> +             /* Warning instead of failing the probe. */
>> +             xmgmt_warn(xm, "create xmgmt root attrs failed: %d", ret);
>> +     }
>> +
>> +     xroot_broadcast(xm->root, XRT_EVENT_POST_CREATION);
>> +     xmgmt_info(xm, "%s started successfully", XMGMT_MODULE_NAME);
>> +     return 0;
>> +
>> +failed_metadata:
>> +     (void)xroot_remove(xm->root);
>> +failed:
>> +     pci_set_drvdata(pdev, NULL);
>> +     return ret;
>> +}
>> +
>> +static void xmgmt_remove(struct pci_dev *pdev)
>> +{
>> +     struct xmgmt *xm = pci_get_drvdata(pdev);
>> +
>> +     xroot_broadcast(xm->root, XRT_EVENT_PRE_REMOVAL);
>> +     sysfs_remove_group(&pdev->dev.kobj, &xmgmt_root_attr_group);
>> +     (void)xroot_remove(xm->root);
>> +     pci_disable_pcie_error_reporting(xm->pdev);
>> +     xmgmt_info(xm, "%s cleaned up successfully", XMGMT_MODULE_NAME);
>> +}
>> +
>> +static struct pci_driver xmgmt_driver = {
>> +     .name = XMGMT_MODULE_NAME,
>> +     .id_table = xmgmt_pci_ids,
>> +     .probe = xmgmt_probe,
>> +     .remove = xmgmt_remove,
>> +};
>> +
>> +static int __init xmgmt_init(void)
>> +{
>> +     int res = 0;
>> +
>> +     res = xmgmt_main_register_leaf();
>> +     if (res)
>> +             return res;
>> +
>> +     xmgmt_class = class_create(THIS_MODULE, XMGMT_MODULE_NAME);
>> +     if (IS_ERR(xmgmt_class))
>> +             return PTR_ERR(xmgmt_class);
>> +
>> +     res = pci_register_driver(&xmgmt_driver);
>> +     if (res) {
>> +             class_destroy(xmgmt_class);
>> +             return res;
>> +     }
>> +
>> +     return 0;
>> +}
>> +
>> +static __exit void xmgmt_exit(void)
>> +{
>> +     pci_unregister_driver(&xmgmt_driver);
>> +     class_destroy(xmgmt_class);
>> +     xmgmt_main_unregister_leaf();
>> +}
>> +
>> +module_init(xmgmt_init);
>> +module_exit(xmgmt_exit);
>> +
>> +MODULE_DEVICE_TABLE(pci, xmgmt_pci_ids);
>> +MODULE_VERSION(XMGMT_DRIVER_VERSION);
>> +MODULE_AUTHOR("XRT Team <runtime@xilinx.com>");
>> +MODULE_DESCRIPTION("Xilinx Alveo management function driver");
>> +MODULE_LICENSE("GPL v2");
