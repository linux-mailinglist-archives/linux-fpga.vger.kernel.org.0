Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD6C33FC5C
	for <lists+linux-fpga@lfdr.de>; Thu, 18 Mar 2021 01:45:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbhCRAoa (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 17 Mar 2021 20:44:30 -0400
Received: from mail-dm6nam11on2055.outbound.protection.outlook.com ([40.107.223.55]:1904
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229769AbhCRAoW (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 17 Mar 2021 20:44:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CarR8DKoQMHAPKijnLvT64RfClVn/9dWn54pPGCQoGRrHAlFTYdwThKSPBaL+/4MAE+QlZwcoBkO5yJAP6GUjtbdKSE2lpNGDNPxg3lfCNzswcqzt+1g/dxumSoNWK+R3Yb9OdSB02rkLQKW8iDdtM2eRK0PyKmd+6vPduNO2hcOFO1gpjSlkkoiwXrB3xqmjflszhqF3vULXGen4AHkXiAGwXimifIhmNrMNDrvWpHCituY2/RN3fNUEkDEwHVnmxn6znQhH8cqCSQKwyk10wA7e5BE8xcK+X+mYXiqWy2YhrkFmf35eLwDRYjAMZMbQgfquUsYLqmYff67re4p8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+gYMvxEwbFchOL6XN8Hup5vCUXBQ328XcFp0lMKsyA=;
 b=Y0t6BmEqzVVpI2KoiSYAYVXMOgysW7uDHGtWH+PzES/b1QGFqqeMSW+XsE7N+rLhWNRANoLg96h59J/uTwJESuGRq24bDepmIiv1yB34ZDHgPnCOiJ1U9klPGPaKpK6ovJ6yYuAaFVxJrpn/x1PmVt6C/+U9CKKVurOoz8I5MNxqXEK0QpmnMclbS7nYhOVjqztTTn9xc6t6jz2pPihh36S4KDgHq3gtEFsVF8PjJsH4iDJixjNNhupfoIU9budXr2goK0R1UZzQokXIalAOcvuD9riW0OozEauCoWF/dGyKFIQliTEuAwTr9zc1ENbgPMBfAI6H1Nxxxn39LopadA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+gYMvxEwbFchOL6XN8Hup5vCUXBQ328XcFp0lMKsyA=;
 b=G2gaxZVOtmLgQczfN/LWvrI72fNDfmVu1FTBcOQC3vCg76YruqRVPtlzff+FthE66/xRJ4aLn0xKP7MIgvQM581DmmatQ45DGflL8mVIpEkYVwFB1g9EGf9W4I78SVrvOSliqQQNZTGQ/9isfJvLKVESzHW3SDT9G6Wx8pZRrxE=
Received: from DM5PR07CA0102.namprd07.prod.outlook.com (2603:10b6:4:ae::31) by
 SN6PR02MB4287.namprd02.prod.outlook.com (2603:10b6:805:a3::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3933.32; Thu, 18 Mar 2021 00:44:17 +0000
Received: from DM3NAM02FT044.eop-nam02.prod.protection.outlook.com
 (2603:10b6:4:ae:cafe::6d) by DM5PR07CA0102.outlook.office365.com
 (2603:10b6:4:ae::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend
 Transport; Thu, 18 Mar 2021 00:44:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT044.mail.protection.outlook.com (10.13.5.98) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3933.32 via Frontend Transport; Thu, 18 Mar 2021 00:44:16 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 17 Mar 2021 17:44:16 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2106.2 via Frontend Transport; Wed, 17 Mar 2021 17:44:16 -0700
Envelope-to: robh@kernel.org,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 mdf@kernel.org,
 linux-kernel@vger.kernel.org,
 trix@redhat.com
Received: from [10.17.3.3] (port=34232)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <max.zhen@xilinx.com>)
        id 1lMgls-0002r9-9k; Wed, 17 Mar 2021 17:44:16 -0700
Subject: Re: [PATCH V3 XRT Alveo 07/18] fpga: xrt: management physical
 function driver (root)
To:     Tom Rix <trix@redhat.com>, Max Zhen <max.zhen@xilinx.com>,
        Lizhi Hou <lizhi.hou@xilinx.com>,
        <linux-kernel@vger.kernel.org>, "mdf@kernel.org" <mdf@kernel.org>
CC:     Lizhi Hou <lizhih@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <sonal.santan@xilinx.com>, <michal.simek@xilinx.com>,
        <stefanos@xilinx.com>, <devicetree@vger.kernel.org>,
        <robh@kernel.org>
References: <20210218064019.29189-1-lizhih@xilinx.com>
 <20210218064019.29189-8-lizhih@xilinx.com>
 <d0057bee-2cf1-b560-c160-636d8e76cbda@redhat.com>
 <dd75e8fa-26ed-11a6-a048-7236918fe25b@xilinx.com>
 <7f2219e6-461f-1126-a48a-c15da974317b@redhat.com>
From:   Max Zhen <max.zhen@xilinx.com>
Message-ID: <b94b5e26-c3de-0b61-8d8b-adde4316f56d@xilinx.com>
Date:   Wed, 17 Mar 2021 17:44:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <7f2219e6-461f-1126-a48a-c15da974317b@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 12f27bf3-6664-47af-9e06-08d8e9a6f5a9
X-MS-TrafficTypeDiagnostic: SN6PR02MB4287:
X-Microsoft-Antispam-PRVS: <SN6PR02MB4287CE17F1C966AD3F001436B9699@SN6PR02MB4287.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qxqbzw/u6Vl3cmyqUqyWRfo+CCCn1YAppECiPd6SfZ6OVQhgHH3YHqXeaSIA9wzPdjc/IRXvG/Feb43MXQi9tvqTlWxmLyhurQJ6x2EUgsRnnU09565j6A594eSfe/KjZkQtUzr58evjQz3hzYR/MdOjdySZ+8w5cveIlIOE1W7pU4lhmCYBczLJsFlN3CiBIjpahknB/g+DK2AfsYjbv+1mQH+6ltH7OhHLp3o8ty5jU0+4t2GRI6kwtWnr03cv4KzVWH//Ja1i3gmGcVYX5Kpu/9hhwNx76gaHeRitiS8MaR+IM/+N6y18xWAeO6q+nLe+AClpmYFdrLe1Xo3PjwKJiSyK2gQAIf/NtaBDjNX0VzrjITOsoh0FI7WeyOxkl2eLW6VfvtL279xwj6wYw0IFXV7CvEv7AL73MciZb4pFPpwaXzWYs63h0pnUtNHN+hG4lllNvNoHC/UBAcvL+gSSgyw/6s0PkTGPyKSOgd6fAF4utr1vwEtPxZHFIUsfv0pfeaCieBQv8EiQWxqmrdqL0jvvim/nq+KQDukFh9/RPXlrdh3a3bFRjw40qn1bvF38w7xNw9KNR88///SZ8qnMlwfrrwE5d6Pw2e8xgqD+qcqICryR/QnaZJTc//9bwE3nkU3wHYvD7ZADipZzMWeG32pNzmXfHWNk8tfUCERZ7zH28KnOUdwxSiYlhp0RwsKYFq98t8tvhKJrCK9oBofEmEQIKSOZBWSAArOOQ3A=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(376002)(39860400002)(36840700001)(46966006)(8936002)(31696002)(9786002)(110136005)(336012)(316002)(26005)(478600001)(83380400001)(186003)(356005)(31686004)(5660300002)(54906003)(7636003)(70206006)(2906002)(8676002)(36906005)(4326008)(47076005)(44832011)(82740400003)(426003)(36860700001)(82310400003)(70586007)(2616005)(30864003)(53546011)(36756003)(50156003)(2101003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2021 00:44:16.7412
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12f27bf3-6664-47af-9e06-08d8e9a6f5a9
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT044.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4287
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 3/17/21 2:08 PM, Tom Rix wrote:
>
> On 3/16/21 1:29 PM, Max Zhen wrote:
>> Hi Tom,
>>
>>
>> On 2/26/21 7:01 AM, Tom Rix wrote:
>>
>>
>>
>> A question i do not know the answer to.
>>
>> Seems like 'golden' is linked to a manufacturing (diagnostics?) image.
>>
>> If the public will never see it, should handling it here be done ?
>>
>> Moritz, do you know ?
>>
>> Golden image is preloaded on the device when it is shipped to customer. Then, customer can load other shells (from Xilinx or some other vendor). If something goes wrong with the shell, customer can always go back to golden and start over again. So, golden image is going to be used in public, not just internally by Xilinx.
>>
>>
> Thanks for the explanation.
>
>
>>>
>>> On 2/17/21 10:40 PM, Lizhi Hou wrote:
>>>> The PCIE device driver which attaches to management function on Alveo
>>> to the management
>>
>> Sure.
>>
>>
>>>> devices. It instantiates one or more partition drivers which in turn
>>> more fpga partition / group ?
>>
>> Group driver.
>>
>>
>>>> instantiate platform drivers. The instantiation of partition and platform
>>>> drivers is completely data driven.
>>> data driven ? everything is data driven.  do you mean dtb driven ?
>>
>> Data driven means not hard-coded. Here data means meta data which is presented in device tree format, dtb.
>>
>>
>>>> Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
>>>> Signed-off-by: Max Zhen <max.zhen@xilinx.com>
>>>> Signed-off-by: Lizhi Hou <lizhih@xilinx.com>
>>>> ---
>>>>    drivers/fpga/xrt/include/xroot.h | 114 +++++++++++
>>>>    drivers/fpga/xrt/mgmt/root.c     | 342 +++++++++++++++++++++++++++++++
>>>>    2 files changed, 456 insertions(+)
>>>>    create mode 100644 drivers/fpga/xrt/include/xroot.h
>>>>    create mode 100644 drivers/fpga/xrt/mgmt/root.c
>>>>
>>>> diff --git a/drivers/fpga/xrt/include/xroot.h b/drivers/fpga/xrt/include/xroot.h
>>>> new file mode 100644
>>>> index 000000000000..752e10daa85e
>>>> --- /dev/null
>>>> +++ b/drivers/fpga/xrt/include/xroot.h
>>>> @@ -0,0 +1,114 @@
>>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>>> +/*
>>>> + * Header file for Xilinx Runtime (XRT) driver
>>>> + *
>>>> + * Copyright (C) 2020-2021 Xilinx, Inc.
>>>> + *
>>>> + * Authors:
>>>> + *   Cheng Zhen <maxz@xilinx.com>
>>>> + */
>>>> +
>>>> +#ifndef _XRT_ROOT_H_
>>>> +#define _XRT_ROOT_H_
>>>> +
>>>> +#include <linux/pci.h>
>>>> +#include "subdev_id.h"
>>>> +#include "events.h"
>>>> +
>>>> +typedef bool (*xrt_subdev_match_t)(enum xrt_subdev_id,
>>>> +     struct platform_device *, void *);
>>>> +#define XRT_SUBDEV_MATCH_PREV        ((xrt_subdev_match_t)-1)
>>>> +#define XRT_SUBDEV_MATCH_NEXT        ((xrt_subdev_match_t)-2)
>>>> +
>>>> +/*
>>>> + * Root IOCTL calls.
>>>> + */
>>>> +enum xrt_root_ioctl_cmd {
>>>> +     /* Leaf actions. */
>>>> +     XRT_ROOT_GET_LEAF = 0,
>>>> +     XRT_ROOT_PUT_LEAF,
>>>> +     XRT_ROOT_GET_LEAF_HOLDERS,
>>>> +
>>>> +     /* Group actions. */
>>>> +     XRT_ROOT_CREATE_GROUP,
>>>> +     XRT_ROOT_REMOVE_GROUP,
>>>> +     XRT_ROOT_LOOKUP_GROUP,
>>>> +     XRT_ROOT_WAIT_GROUP_BRINGUP,
>>>> +
>>>> +     /* Event actions. */
>>>> +     XRT_ROOT_EVENT,
>>> should this be XRT_ROOT_EVENT_SYNC ?
>>
>> Sure.
>>
>>
>>>> +     XRT_ROOT_EVENT_ASYNC,
>>>> +
>>>> +     /* Device info. */
>>>> +     XRT_ROOT_GET_RESOURCE,
>>>> +     XRT_ROOT_GET_ID,
>>>> +
>>>> +     /* Misc. */
>>>> +     XRT_ROOT_HOT_RESET,
>>>> +     XRT_ROOT_HWMON,
>>>> +};
>>>> +
>>>> +struct xrt_root_ioctl_get_leaf {
>>>> +     struct platform_device *xpigl_pdev; /* caller's pdev */
>>> xpigl_ ? unneeded suffix in element names
>>
>> It's needed since the it might be included and used in > 1 .c files. I'd like to keep it's name unique.
> This is an element name, the variable name sound be unique enough to make it clear.
>
> This is not a critical issue, ok as-is.
>
>>
>>>> +     xrt_subdev_match_t xpigl_match_cb;
>>>> +     void *xpigl_match_arg;
>>>> +     struct platform_device *xpigl_leaf; /* target leaf pdev */
>>>> +};
>>>> +
>>>> +struct xrt_root_ioctl_put_leaf {
>>>> +     struct platform_device *xpipl_pdev; /* caller's pdev */
>>>> +     struct platform_device *xpipl_leaf; /* target's pdev */
>>> caller_pdev;
>>>
>>> target_pdev;
>>
>> Sure.
>>
>>
>>>> +};
>>>> +
>>>> +struct xrt_root_ioctl_lookup_group {
>>>> +     struct platform_device *xpilp_pdev; /* caller's pdev */
>>>> +     xrt_subdev_match_t xpilp_match_cb;
>>>> +     void *xpilp_match_arg;
>>>> +     int xpilp_grp_inst;
>>>> +};
>>>> +
>>>> +struct xrt_root_ioctl_get_holders {
>>>> +     struct platform_device *xpigh_pdev; /* caller's pdev */
>>>> +     char *xpigh_holder_buf;
>>>> +     size_t xpigh_holder_buf_len;
>>>> +};
>>>> +
>>>> +struct xrt_root_ioctl_get_res {
>>>> +     struct resource *xpigr_res;
>>>> +};
>>>> +
>>>> +struct xrt_root_ioctl_get_id {
>>>> +     unsigned short  xpigi_vendor_id;
>>>> +     unsigned short  xpigi_device_id;
>>>> +     unsigned short  xpigi_sub_vendor_id;
>>>> +     unsigned short  xpigi_sub_device_id;
>>>> +};
>>>> +
>>>> +struct xrt_root_ioctl_hwmon {
>>>> +     bool xpih_register;
>>>> +     const char *xpih_name;
>>>> +     void *xpih_drvdata;
>>>> +     const struct attribute_group **xpih_groups;
>>>> +     struct device *xpih_hwmon_dev;
>>>> +};
>>>> +
>>>> +typedef int (*xrt_subdev_root_cb_t)(struct device *, void *, u32, void *);
>>> This function pointer type is important, please add a comment about its use and expected parameters
>>
>> Added.
>>
>>
>>>> +int xrt_subdev_root_request(struct platform_device *self, u32 cmd, void *arg);
>>>> +
>>>> +/*
>>>> + * Defines physical function (MPF / UPF) specific operations
>>>> + * needed in common root driver.
>>>> + */
>>>> +struct xroot_pf_cb {
>>>> +     void (*xpc_hot_reset)(struct pci_dev *pdev);
>>> This is only ever set to xmgmt_root_hot_reset, why is this abstraction needed ?
>>
>> As comment says, hot reset is implemented differently in MPF and UPF driver. So, we need this callback in this common code. Note that we have not added UPF code in our initial patch yet. It will be added in the future.
>>
>>
>>>> +};
>>>> +
>>>> +int xroot_probe(struct pci_dev *pdev, struct xroot_pf_cb *cb, void **root);
>>>> +void xroot_remove(void *root);
>>>> +bool xroot_wait_for_bringup(void *root);
>>>> +int xroot_add_vsec_node(void *root, char *dtb);
>>>> +int xroot_create_group(void *xr, char *dtb);
>>>> +int xroot_add_simple_node(void *root, char *dtb, const char *endpoint);
>>>> +void xroot_broadcast(void *root, enum xrt_events evt);
>>>> +
>>>> +#endif       /* _XRT_ROOT_H_ */
>>>> diff --git a/drivers/fpga/xrt/mgmt/root.c b/drivers/fpga/xrt/mgmt/root.c
>>>> new file mode 100644
>>>> index 000000000000..583a37c9d30c
>>>> --- /dev/null
>>>> +++ b/drivers/fpga/xrt/mgmt/root.c
>>>> @@ -0,0 +1,342 @@
>>>> +// SPDX-License-Identifier: GPL-2.0
>>>> +/*
>>>> + * Xilinx Alveo Management Function Driver
>>>> + *
>>>> + * Copyright (C) 2020-2021 Xilinx, Inc.
>>>> + *
>>>> + * Authors:
>>>> + *   Cheng Zhen <maxz@xilinx.com>
>>>> + */
>>>> +
>>>> +#include <linux/module.h>
>>>> +#include <linux/pci.h>
>>>> +#include <linux/aer.h>
>>>> +#include <linux/vmalloc.h>
>>>> +#include <linux/delay.h>
>>>> +
>>>> +#include "xroot.h"
>>>> +#include "main-impl.h"
>>>> +#include "metadata.h"
>>>> +
>>>> +#define XMGMT_MODULE_NAME    "xmgmt"
>>> The xrt modules would be more easily identified with a 'xrt' prefix instead of 'x'
>>
>> We will change the module name to xrt-mgmt.
>>
>>
>>>> +#define XMGMT_DRIVER_VERSION "4.0.0"
>>>> +
>>>> +#define XMGMT_PDEV(xm)               ((xm)->pdev)
>>>> +#define XMGMT_DEV(xm)                (&(XMGMT_PDEV(xm)->dev))
>>>> +#define xmgmt_err(xm, fmt, args...)  \
>>>> +     dev_err(XMGMT_DEV(xm), "%s: " fmt, __func__, ##args)
>>>> +#define xmgmt_warn(xm, fmt, args...) \
>>>> +     dev_warn(XMGMT_DEV(xm), "%s: " fmt, __func__, ##args)
>>>> +#define xmgmt_info(xm, fmt, args...) \
>>>> +     dev_info(XMGMT_DEV(xm), "%s: " fmt, __func__, ##args)
>>>> +#define xmgmt_dbg(xm, fmt, args...)  \
>>>> +     dev_dbg(XMGMT_DEV(xm), "%s: " fmt, __func__, ##args)
>>>> +#define XMGMT_DEV_ID(_pcidev)                        \
>>>> +     ({ typeof(_pcidev) (pcidev) = (_pcidev);        \
>>>> +     ((pci_domain_nr((pcidev)->bus) << 16) | \
>>>> +     PCI_DEVID((pcidev)->bus->number, 0)); })
>>>> +
>>>> +static struct class *xmgmt_class;
>>>> +static const struct pci_device_id xmgmt_pci_ids[] = {
>>>> +     { PCI_DEVICE(0x10EE, 0xd020), }, /* Alveo U50 (golden image) */
>>>> +     { PCI_DEVICE(0x10EE, 0x5020), }, /* Alveo U50 */
>>> demagic this table, look at dfl-pci for how to use existing #define for the vendor and create a new on for the device.  If there are vf's add them at the same time.
>>>
>>> What is a golden image ?
>>
>> Fixed. Please see my comments above for golden image.
>>
>>
>>>> +     { 0, }
>>>> +};
>>>> +
>>>> +struct xmgmt {
>>>> +     struct pci_dev *pdev;
>>>> +     void *root;
>>>> +
>>>> +     bool ready;
>>>> +};
>>>> +
>>>> +static int xmgmt_config_pci(struct xmgmt *xm)
>>>> +{
>>>> +     struct pci_dev *pdev = XMGMT_PDEV(xm);
>>>> +     int rc;
>>>> +
>>>> +     rc = pcim_enable_device(pdev);
>>>> +     if (rc < 0) {
>>>> +             xmgmt_err(xm, "failed to enable device: %d", rc);
>>>> +             return rc;
>>>> +     }
>>>> +
>>>> +     rc = pci_enable_pcie_error_reporting(pdev);
>>>> +     if (rc)
>>>> +             xmgmt_warn(xm, "failed to enable AER: %d", rc);
>>>> +
>>>> +     pci_set_master(pdev);
>>>> +
>>>> +     rc = pcie_get_readrq(pdev);
>>> Review this call, it does not go negative
>>
>> I'll remove the check against negative value.
>>
>>
>>>> +     if (rc < 0) {
>>>> +             xmgmt_err(xm, "failed to read mrrs %d", rc);
>>>> +             return rc;
>>>> +     }
>>> this is a quirk, add a comment.
>>
>> Will remove.
>>
>>
>>>> +     if (rc > 512) {
>>>> +             rc = pcie_set_readrq(pdev, 512);
>>>> +             if (rc) {
>>>> +                     xmgmt_err(xm, "failed to force mrrs %d", rc);
>>> similar calls do not fail here.
>>
>> Will remove.
>>
>>
>>>> +                     return rc;
>>>> +             }
>>>> +     }
>>>> +
>>>> +     return 0;
>>>> +}
>>>> +
>>>> +static int xmgmt_match_slot_and_save(struct device *dev, void *data)
>>>> +{
>>>> +     struct xmgmt *xm = data;
>>>> +     struct pci_dev *pdev = to_pci_dev(dev);
>>>> +
>>>> +     if (XMGMT_DEV_ID(pdev) == XMGMT_DEV_ID(xm->pdev)) {
>>>> +             pci_cfg_access_lock(pdev);
>>>> +             pci_save_state(pdev);
>>>> +     }
>>>> +
>>>> +     return 0;
>>>> +}
>>>> +
>>>> +static void xmgmt_pci_save_config_all(struct xmgmt *xm)
>>>> +{
>>>> +     bus_for_each_dev(&pci_bus_type, NULL, xm, xmgmt_match_slot_and_save);
>>> This is a bus call, not a device call.
>>>
>>> Can this be changed into something like what hot reset does ?
>>
>> We are working on both mgmt pf and user pf here, so sort of like a bus. But, it might be better to refactor this when we have our own bus type implementation. We do not need to make PCIE bus call. We will fix this in V5 patch set where we'll implement our own bus type.
>>
>>
> ok
>>>> +}
>>>> +
>>>> +static int xmgmt_match_slot_and_restore(struct device *dev, void *data)
>>>> +{
>>>> +     struct xmgmt *xm = data;
>>>> +     struct pci_dev *pdev = to_pci_dev(dev);
>>>> +
>>>> +     if (XMGMT_DEV_ID(pdev) == XMGMT_DEV_ID(xm->pdev)) {
>>>> +             pci_restore_state(pdev);
>>>> +             pci_cfg_access_unlock(pdev);
>>>> +     }
>>>> +
>>>> +     return 0;
>>>> +}
>>>> +
>>>> +static void xmgmt_pci_restore_config_all(struct xmgmt *xm)
>>>> +{
>>>> +     bus_for_each_dev(&pci_bus_type, NULL, xm, xmgmt_match_slot_and_restore);
>>>> +}
>>>> +
>>>> +static void xmgmt_root_hot_reset(struct pci_dev *pdev)
>>>> +{
>>>> +     struct xmgmt *xm = pci_get_drvdata(pdev);
>>>> +     struct pci_bus *bus;
>>>> +     u8 pci_bctl;
>>>> +     u16 pci_cmd, devctl;
>>>> +     int i, ret;
>>>> +
>>>> +     xmgmt_info(xm, "hot reset start");
>>>> +
>>>> +     xmgmt_pci_save_config_all(xm);
>>>> +
>>>> +     pci_disable_device(pdev);
>>>> +
>>>> +     bus = pdev->bus;
>>>> +
>>>> +     /*
>>>> +      * When flipping the SBR bit, device can fall off the bus. This is
>>>> +      * usually no problem at all so long as drivers are working properly
>>>> +      * after SBR. However, some systems complain bitterly when the device
>>>> +      * falls off the bus.
>>>> +      * The quick solution is to temporarily disable the SERR reporting of
>>>> +      * switch port during SBR.
>>>> +      */
>>>> +
>>>> +     pci_read_config_word(bus->self, PCI_COMMAND, &pci_cmd);
>>>> +     pci_write_config_word(bus->self, PCI_COMMAND,
>>>> +                           (pci_cmd & ~PCI_COMMAND_SERR));
>>>> +     pcie_capability_read_word(bus->self, PCI_EXP_DEVCTL, &devctl);
>>>> +     pcie_capability_write_word(bus->self, PCI_EXP_DEVCTL,
>>>> +                                (devctl & ~PCI_EXP_DEVCTL_FERE));
>>>> +     pci_read_config_byte(bus->self, PCI_BRIDGE_CONTROL, &pci_bctl);
>>>> +     pci_bctl |= PCI_BRIDGE_CTL_BUS_RESET;
>>>> +     pci_write_config_byte(bus->self, PCI_BRIDGE_CONTROL, pci_bctl);
>>> how the pci config values are set and cleared should be consistent.
>>>
>>> this call should be
>>>
>>> pci_write_config_byte (... pci_bctl | PCI_BRIDGE_CTL_BUF_RESET )
>>>
>>> and the next &= avoided
>>
>> Sure.
>>
>>
>>>> +
>>>> +     msleep(100);
>>>> +     pci_bctl &= ~PCI_BRIDGE_CTL_BUS_RESET;
>>>> +     pci_write_config_byte(bus->self, PCI_BRIDGE_CONTROL, pci_bctl);
>>>> +     ssleep(1);
>>>> +
>>>> +     pcie_capability_write_word(bus->self, PCI_EXP_DEVCTL, devctl);
>>>> +     pci_write_config_word(bus->self, PCI_COMMAND, pci_cmd);
>>>> +
>>>> +     ret = pci_enable_device(pdev);
>>>> +     if (ret)
>>>> +             xmgmt_err(xm, "failed to enable device, ret %d", ret);
>>>> +
>>>> +     for (i = 0; i < 300; i++) {
>>>> +             pci_read_config_word(pdev, PCI_COMMAND, &pci_cmd);
>>>> +             if (pci_cmd != 0xffff)
>>> what happens with i == 300 and pci_cmd is still 0xffff ?
>>
>> Something wrong happens to the device since it's not coming back after the reset. In this case, the device cannot be used and the only way to recover is to power cycle the system so that the shell can be reloaded from the flash on the device.
>>
>>
> so check and add a dev_crit() to let the user know.


Sure. Will do.


Thanks,

Max

>>>> +                     break;
>>>> +             msleep(20);
>>>> +     }
>>>> +
>>>> +     xmgmt_info(xm, "waiting for %d ms", i * 20);
>>>> +     xmgmt_pci_restore_config_all(xm);
>>>> +     xmgmt_config_pci(xm);
>>>> +}
>>>> +
>>>> +static int xmgmt_create_root_metadata(struct xmgmt *xm, char **root_dtb)
>>>> +{
>>>> +     char *dtb = NULL;
>>>> +     int ret;
>>>> +
>>>> +     ret = xrt_md_create(XMGMT_DEV(xm), &dtb);
>>>> +     if (ret) {
>>>> +             xmgmt_err(xm, "create metadata failed, ret %d", ret);
>>>> +             goto failed;
>>>> +     }
>>>> +
>>>> +     ret = xroot_add_vsec_node(xm->root, dtb);
>>>> +     if (ret == -ENOENT) {
>>>> +             /*
>>>> +              * We may be dealing with a MFG board.
>>>> +              * Try vsec-golden which will bring up all hard-coded leaves
>>>> +              * at hard-coded offsets.
>>>> +              */
>>>> +             ret = xroot_add_simple_node(xm->root, dtb, XRT_MD_NODE_VSEC_GOLDEN);
>>> Manufacturing diagnostics ?
>>
>> This is for golden image support. Please see my comments above.
> Ok, i got it :)
>
> Thanks, looking forward next rev
>
> Tom
>
>>
>> Thanks,
>>
>> Max
>>
>>> Tom
>>>
>>>> +     } else if (ret == 0) {
>>>> +             ret = xroot_add_simple_node(xm->root, dtb, XRT_MD_NODE_MGMT_MAIN);
>>>> +     }
>>>> +     if (ret)
>>>> +             goto failed;
>>>> +
>>>> +     *root_dtb = dtb;
>>>> +     return 0;
>>>> +
>>>> +failed:
>>>> +     vfree(dtb);
>>>> +     return ret;
>>>> +}
>>>> +
>>>> +static ssize_t ready_show(struct device *dev,
>>>> +                       struct device_attribute *da,
>>>> +                       char *buf)
>>>> +{
>>>> +     struct pci_dev *pdev = to_pci_dev(dev);
>>>> +     struct xmgmt *xm = pci_get_drvdata(pdev);
>>>> +
>>>> +     return sprintf(buf, "%d\n", xm->ready);
>>>> +}
>>>> +static DEVICE_ATTR_RO(ready);
>>>> +
>>>> +static struct attribute *xmgmt_root_attrs[] = {
>>>> +     &dev_attr_ready.attr,
>>>> +     NULL
>>>> +};
>>>> +
>>>> +static struct attribute_group xmgmt_root_attr_group = {
>>>> +     .attrs = xmgmt_root_attrs,
>>>> +};
>>>> +
>>>> +static struct xroot_pf_cb xmgmt_xroot_pf_cb = {
>>>> +     .xpc_hot_reset = xmgmt_root_hot_reset,
>>>> +};
>>>> +
>>>> +static int xmgmt_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>>> +{
>>>> +     int ret;
>>>> +     struct device *dev = &pdev->dev;
>>>> +     struct xmgmt *xm = devm_kzalloc(dev, sizeof(*xm), GFP_KERNEL);
>>>> +     char *dtb = NULL;
>>>> +
>>>> +     if (!xm)
>>>> +             return -ENOMEM;
>>>> +     xm->pdev = pdev;
>>>> +     pci_set_drvdata(pdev, xm);
>>>> +
>>>> +     ret = xmgmt_config_pci(xm);
>>>> +     if (ret)
>>>> +             goto failed;
>>>> +
>>>> +     ret = xroot_probe(pdev, &xmgmt_xroot_pf_cb, &xm->root);
>>>> +     if (ret)
>>>> +             goto failed;
>>>> +
>>>> +     ret = xmgmt_create_root_metadata(xm, &dtb);
>>>> +     if (ret)
>>>> +             goto failed_metadata;
>>>> +
>>>> +     ret = xroot_create_group(xm->root, dtb);
>>>> +     vfree(dtb);
>>>> +     if (ret)
>>>> +             xmgmt_err(xm, "failed to create root group: %d", ret);
>>>> +
>>>> +     if (!xroot_wait_for_bringup(xm->root))
>>>> +             xmgmt_err(xm, "failed to bringup all groups");
>>>> +     else
>>>> +             xm->ready = true;
>>>> +
>>>> +     ret = sysfs_create_group(&pdev->dev.kobj, &xmgmt_root_attr_group);
>>>> +     if (ret) {
>>>> +             /* Warning instead of failing the probe. */
>>>> +             xmgmt_warn(xm, "create xmgmt root attrs failed: %d", ret);
>>>> +     }
>>>> +
>>>> +     xroot_broadcast(xm->root, XRT_EVENT_POST_CREATION);
>>>> +     xmgmt_info(xm, "%s started successfully", XMGMT_MODULE_NAME);
>>>> +     return 0;
>>>> +
>>>> +failed_metadata:
>>>> +     (void)xroot_remove(xm->root);
>>>> +failed:
>>>> +     pci_set_drvdata(pdev, NULL);
>>>> +     return ret;
>>>> +}
>>>> +
>>>> +static void xmgmt_remove(struct pci_dev *pdev)
>>>> +{
>>>> +     struct xmgmt *xm = pci_get_drvdata(pdev);
>>>> +
>>>> +     xroot_broadcast(xm->root, XRT_EVENT_PRE_REMOVAL);
>>>> +     sysfs_remove_group(&pdev->dev.kobj, &xmgmt_root_attr_group);
>>>> +     (void)xroot_remove(xm->root);
>>>> +     pci_disable_pcie_error_reporting(xm->pdev);
>>>> +     xmgmt_info(xm, "%s cleaned up successfully", XMGMT_MODULE_NAME);
>>>> +}
>>>> +
>>>> +static struct pci_driver xmgmt_driver = {
>>>> +     .name = XMGMT_MODULE_NAME,
>>>> +     .id_table = xmgmt_pci_ids,
>>>> +     .probe = xmgmt_probe,
>>>> +     .remove = xmgmt_remove,
>>>> +};
>>>> +
>>>> +static int __init xmgmt_init(void)
>>>> +{
>>>> +     int res = 0;
>>>> +
>>>> +     res = xmgmt_main_register_leaf();
>>>> +     if (res)
>>>> +             return res;
>>>> +
>>>> +     xmgmt_class = class_create(THIS_MODULE, XMGMT_MODULE_NAME);
>>>> +     if (IS_ERR(xmgmt_class))
>>>> +             return PTR_ERR(xmgmt_class);
>>>> +
>>>> +     res = pci_register_driver(&xmgmt_driver);
>>>> +     if (res) {
>>>> +             class_destroy(xmgmt_class);
>>>> +             return res;
>>>> +     }
>>>> +
>>>> +     return 0;
>>>> +}
>>>> +
>>>> +static __exit void xmgmt_exit(void)
>>>> +{
>>>> +     pci_unregister_driver(&xmgmt_driver);
>>>> +     class_destroy(xmgmt_class);
>>>> +     xmgmt_main_unregister_leaf();
>>>> +}
>>>> +
>>>> +module_init(xmgmt_init);
>>>> +module_exit(xmgmt_exit);
>>>> +
>>>> +MODULE_DEVICE_TABLE(pci, xmgmt_pci_ids);
>>>> +MODULE_VERSION(XMGMT_DRIVER_VERSION);
>>>> +MODULE_AUTHOR("XRT Team <runtime@xilinx.com>");
>>>> +MODULE_DESCRIPTION("Xilinx Alveo management function driver");
>>>> +MODULE_LICENSE("GPL v2");
