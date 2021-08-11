Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 050103E9A3E
	for <lists+linux-fpga@lfdr.de>; Wed, 11 Aug 2021 23:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbhHKVJi (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 11 Aug 2021 17:09:38 -0400
Received: from mail-mw2nam12on2072.outbound.protection.outlook.com ([40.107.244.72]:21312
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229655AbhHKVJg (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 11 Aug 2021 17:09:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nXjegIsGcKOrWhDxNaaL1ZaMGHCCPEw24M7uatv/DZdJE9XQ9pGjmH2a94o3UFcdyurxx+QunaODs29m9v7yFy/qgeEUuX5VfHyHsl0q6qmkKOr9GB5k5kwvF+7RANBg6GPWdk2+4pirhLqvtgEcsdPXpfEnHvqDsZ0W1b73Allye7wSLxY6O71jbwLcDFI7VphS2wyWOx8qySp3gq6CBTrAAThX8pz/1Gdx+iOsC6dhLUmVQhxUo155yGqK1pvCeWm2RRacgvtSpC1grXebh5vHXPmiKgf0mwXdR/VzCXzfS3R9ygy4G+I8vxPHlLF5mehr/fniyqH0zRX386BJww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jahx9IVJrgXhjNcw+TrxWuePyrE3q7MyRzyhQ4bJm6c=;
 b=gFQ4RWRsoXqeaFTpYjXQSRjEqYQLRbBAdeC7A/uAC4sLTztQL0eWZ6GpdOuV2jSbHM3jse6SG2EpyKYDC5llQOQyJGOsVqY6tbB7F1bTode0/jz6RsBNOewKNLCcQCNS+ovqa4yA43TvzmSWRwNooKxZBK9+hYrmunBV4V5C1chhTcEZipzrIzygL4mofmea1VaZc+6APwJOykp2shsIFW/zgzhD0Dwk1j3FAcEmVtOhTsfG1NYJc6q0xWTFrN8y4LlmS7b2qcS5+10p0jy6joQnaBRY3bXlEcn1/EQinLz3w4KgQ5ZsKP/oOKksoRvMs46IOiIVgx49/hoX8ceNVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jahx9IVJrgXhjNcw+TrxWuePyrE3q7MyRzyhQ4bJm6c=;
 b=j79EjMQCiRcOZQnpkY2VyOHq7eeoBvufnsuNLaJZcTdrgbcbpqdDWmPgyBbslMdRehi6d41m+QsOREXwPpdCQEyNHseBqkS/NeImypib4THywmpDMzwVLxPGJHGn5TnvWa//lBd5F9BqY6ZZ29PnCWAb87Lz0sVPy1UitpkmAXs=
Received: from DM6PR02CA0144.namprd02.prod.outlook.com (2603:10b6:5:332::11)
 by SN6PR02MB4526.namprd02.prod.outlook.com (2603:10b6:805:af::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.21; Wed, 11 Aug
 2021 21:09:09 +0000
Received: from DM3NAM02FT058.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:332:cafe::d9) by DM6PR02CA0144.outlook.office365.com
 (2603:10b6:5:332::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16 via Frontend
 Transport; Wed, 11 Aug 2021 21:09:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT058.mail.protection.outlook.com (10.13.5.42) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4415.16 via Frontend Transport; Wed, 11 Aug 2021 21:09:09 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 11 Aug 2021 14:09:08 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Wed, 11 Aug 2021 14:09:08 -0700
Envelope-to: robh@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 mdf@kernel.org
Received: from [10.17.2.60] (port=39648)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1mDvTI-000FMu-CE; Wed, 11 Aug 2021 14:09:08 -0700
Subject: Re: [PATCH V8 XRT Alveo 04/14] fpga: xrt: xrt-lib driver manager
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     Moritz Fischer <mdf@kernel.org>, Lizhi Hou <lizhi.hou@xilinx.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <robh@kernel.org>,
        Max Zhen <max.zhen@xilinx.com>
References: <20210719212628.134129-1-lizhi.hou@xilinx.com>
 <20210719212628.134129-5-lizhi.hou@xilinx.com> <YP42zE2ljx4hHj40@epycbox.lan>
 <da5fa0ba-5321-9a9c-e20f-a9c993417f05@xilinx.com>
Message-ID: <42f5455b-8c7c-c4e6-86db-c2b99acd1a32@xilinx.com>
Date:   Wed, 11 Aug 2021 14:09:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <da5fa0ba-5321-9a9c-e20f-a9c993417f05@xilinx.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9e6ae024-b935-4dab-365f-08d95d0c42d1
X-MS-TrafficTypeDiagnostic: SN6PR02MB4526:
X-Microsoft-Antispam-PRVS: <SN6PR02MB452636B2F5845ABF5A075F07A1F89@SN6PR02MB4526.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:210;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8tZLCVzFsnWGhdKZYC5eLiSLpoV+97pbPvfVKqiYgpcqdnAmZPBfWxQSOayB6hpVVge41UpPQErJUaewgaeLUuJnHBh8WcgDHiXQMKbw+qbskB7wR6WO7qdIqsEzwC09pEHHnljg4wQeZ+ipD0OLzIVryI8PS2uuPEM7qRuBmNdZ4LH0bi5S8agUaVzx09dBGDbks9QeFTO596NIJq7+eHLr6axzWQf/5zqo2BmJGv6pjoSHuM977WgjCdK/T1F8nEUeYlNxnDFKBNFE4wINVY/SGz88iMFzA0Qubmf1ew8BkgUgVo1tVeTGHO8ss3RoUSZRJTtv3DRcU6SjRDwJmIGMcv5AiBbJBEj7z9cEKothyFSU5nHcV0sfK+ax/wJmjSPZiOx4gU+F2U9v38uyJCDskKTt/gJREan1wuO+zab2CuHBS+Kh2aHgYaB8bQj45kaVNHRjF5hEHnm3451NNKUeSGa8tQi+K3xEkteCbt7cKWhMSJcw9QxFJU/vIjsj4Mz24PP0sVgQoDZVtnCauJhMCmJkd+wLiI+1DI5/hkWcK2vhto1Ght4QWRBm73WqU/xIY53yF/zKHPTxRNitNA4Xy7Q7jmUUm+yx+xqHRC/dD+1D/Lo6RT3r6ezX7++pPo7+I8EfQEkD4Lkahr0FVbWeCKtvukzG5MkUjPYQ2aw6JrXnZdcfvg8iV/Ukhunr5kMd6csbSXVd54BwiVT1NTl9pPzWWW1ay0C/8mHSRQSElXghPeWL2RpRMwXRvPTqCwfqcQCwLuiNa109TI5OGA==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(8936002)(70206006)(30864003)(356005)(83380400001)(7636003)(70586007)(31686004)(36906005)(36756003)(9786002)(47076005)(5660300002)(8676002)(82310400003)(54906003)(53546011)(26005)(4326008)(107886003)(2616005)(186003)(44832011)(110136005)(36860700001)(316002)(2906002)(426003)(336012)(508600001)(31696002)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2021 21:09:09.0724
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e6ae024-b935-4dab-365f-08d95d0c42d1
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT058.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4526
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Moritz,


Did you get a chance to review XRT V9 patchset which has fixes you 
suggested? Do you have more comments for XRT patches?


Thanks,

Lizhi

On 7/26/21 4:36 PM, Lizhi Hou wrote:
> Hi Moritz,
>
>
> On 07/25/2021 09:15 PM, Moritz Fischer wrote:
>> On Mon, Jul 19, 2021 at 02:26:18PM -0700, Lizhi Hou wrote:
>>> xrt-lib kernel module infrastructure code to register and manage all
>>> leaf driver modules.
>>>
>>> Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
>>> Signed-off-by: Max Zhen <max.zhen@xilinx.com>
>>> Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
>>> Reviewed-by: Tom Rix <trix@redhat.com>
>>> ---
>>>   drivers/fpga/xrt/include/subdev_id.h          |  39 +++
>>>   drivers/fpga/xrt/include/xdevice.h            | 131 +++++++
>>>   drivers/fpga/xrt/include/xleaf.h              | 205 +++++++++++
>>>   drivers/fpga/xrt/include/xleaf/clkfreq.h      |  21 ++
>>>   drivers/fpga/xrt/include/xleaf/clock.h        |  29 ++
>>>   .../fpga/xrt/include/xleaf/ddr_calibration.h  |  28 ++
>>>   drivers/fpga/xrt/include/xleaf/devctl.h       |  40 +++
>>>   drivers/fpga/xrt/lib/lib-drv.c                | 322 
>>> ++++++++++++++++++
>>>   drivers/fpga/xrt/lib/lib-drv.h                |  21 ++
>>>   9 files changed, 836 insertions(+)
>>>   create mode 100644 drivers/fpga/xrt/include/subdev_id.h
>>>   create mode 100644 drivers/fpga/xrt/include/xdevice.h
>>>   create mode 100644 drivers/fpga/xrt/include/xleaf.h
>>>   create mode 100644 drivers/fpga/xrt/include/xleaf/clkfreq.h
>>>   create mode 100644 drivers/fpga/xrt/include/xleaf/clock.h
>>>   create mode 100644 drivers/fpga/xrt/include/xleaf/ddr_calibration.h
>>>   create mode 100644 drivers/fpga/xrt/include/xleaf/devctl.h
>>>   create mode 100644 drivers/fpga/xrt/lib/lib-drv.c
>>>   create mode 100644 drivers/fpga/xrt/lib/lib-drv.h
>>>
>>> diff --git a/drivers/fpga/xrt/include/subdev_id.h 
>>> b/drivers/fpga/xrt/include/subdev_id.h
>>> new file mode 100644
>>> index 000000000000..02df4b939a1b
>>> --- /dev/null
>>> +++ b/drivers/fpga/xrt/include/subdev_id.h
>>> @@ -0,0 +1,39 @@
>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>> +/*
>>> + * Copyright (C) 2020-2021 Xilinx, Inc.
>>> + *
>>> + * Authors:
>>> + *   Cheng Zhen <maxz@xilinx.com>
>>> + */
>>> +
>>> +#ifndef _XRT_SUBDEV_ID_H_
>>> +#define _XRT_SUBDEV_ID_H_
>>> +
>>> +/*
>>> + * Every subdev driver has an ID for others to refer to it. There 
>>> can be multiple number of
>>> + * instances of a subdev driver. A <subdev_id, subdev_instance> 
>>> tuple is a unique identification
>>> + * of a specific instance of a subdev driver.
>>> + */
>>> +enum xrt_subdev_id {
>>> +     XRT_SUBDEV_INVALID = 0,
>>> +     XRT_SUBDEV_GRP,
>>> +     XRT_SUBDEV_VSEC,
>>> +     XRT_SUBDEV_VSEC_GOLDEN,
>>> +     XRT_SUBDEV_DEVCTL,
>>> +     XRT_SUBDEV_AXIGATE,
>>> +     XRT_SUBDEV_ICAP,
>>> +     XRT_SUBDEV_TEST,
>>> +     XRT_SUBDEV_MGMT_MAIN,
>>> +     XRT_SUBDEV_QSPI,
>>> +     XRT_SUBDEV_MAILBOX,
>>> +     XRT_SUBDEV_CMC,
>>> +     XRT_SUBDEV_CALIB,
>>> +     XRT_SUBDEV_CLKFREQ,
>>> +     XRT_SUBDEV_CLOCK,
>>> +     XRT_SUBDEV_SRSR,
>>> +     XRT_SUBDEV_UCS,
>>> +     XRT_SUBDEV_NUM, /* Total number of subdevs. */
>>> +     XRT_ROOT = -1, /* Special ID for root driver. */
>>> +};
>>> +
>>> +#endif       /* _XRT_SUBDEV_ID_H_ */
>>> diff --git a/drivers/fpga/xrt/include/xdevice.h 
>>> b/drivers/fpga/xrt/include/xdevice.h
>>> new file mode 100644
>>> index 000000000000..3afd96989fc5
>>> --- /dev/null
>>> +++ b/drivers/fpga/xrt/include/xdevice.h
>>> @@ -0,0 +1,131 @@
>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>> +/*
>>> + * Copyright (C) 2020-2021 Xilinx, Inc.
>>> + *
>>> + * Authors:
>>> + *    Lizhi Hou <lizhi.hou@xilinx.com>
>>> + */
>>> +
>>> +#ifndef _XRT_DEVICE_H_
>>> +#define _XRT_DEVICE_H_
>>> +
>>> +#include <linux/fs.h>
>>> +#include <linux/cdev.h>
>>> +
>>> +#define XRT_MAX_DEVICE_NODES         128
>>> +#define XRT_INVALID_DEVICE_INST (XRT_MAX_DEVICE_NODES + 1)
>>> +
>>> +enum {
>>> +     XRT_DEVICE_STATE_NONE = 0,
>>> +     XRT_DEVICE_STATE_ADDED
>>> +};
>>> +
>>> +/*
>>> + * struct xrt_device - represent an xrt device on xrt bus
>>> + *
>>> + * dev: generic device interface.
>>> + * id: id of the xrt device.
>> Shouldn't this document the rest of the members?
> Sure. I will add comments as below.
>
> * dev: generic device interface.
> * subdev_id: id of the xrt device. See enum xrt_subdev_id.
> * name: name of the xrt device.
> * instance: instance of the xrt device. The xrt device with same id 
> can have
> *           more than 1 instances.
> * state: current state of the xrt device.
> * num_resources: The total number of resource for the xrt device.
> * resource: point to the xrt device resource array.
> * sdev_data: private data pointer.
>
>>
>>> + */
>>> +struct xrt_device {
>>> +     struct device dev;
>>> +     u32 subdev_id;
>>> +     const char *name;
>>> +     u32 instance;
>>> +     u32 state;
>>> +     u32 num_resources;
>>> +     struct resource *resource;
>>> +     void *sdev_data;
>>> +};
>>> +
>>> +/*
>>> + * If populated by xrt device driver, infra will handle the 
>>> mechanics of
>>> + * char device (un)registration.
>>> + */
>>> +enum xrt_dev_file_mode {
>>> +     /* Infra create cdev, default file name */
>>> +     XRT_DEV_FILE_DEFAULT = 0,
>>> +     /* Infra create cdev, need to encode inst num in file name */
>>> +     XRT_DEV_FILE_MULTI_INST,
>>> +     /* No auto creation of cdev by infra, leaf handles it by 
>>> itself */
>>> +     XRT_DEV_FILE_NO_AUTO,
>>> +};
>>> +
>>> +struct xrt_dev_file_ops {
>>> +     const struct file_operations xsf_ops;
>>> +     dev_t xsf_dev_t;
>>> +     const char *xsf_dev_name;
>>> +     enum xrt_dev_file_mode xsf_mode;
>>> +};
>>> +
>>> +/*
>>> + * this struct define the endpoints belong to the same xrt device
>>> + */
>> ep_name: ... etc?
> I will add comment as below.
>
> * ep_name: endpoint name
> * compat: compatible string
>
>>> +struct xrt_dev_ep_names {
>>> +     const char *ep_name;
>>> +     const char *compat;
>>> +};
>>> +
>>> +struct xrt_dev_endpoints {
>>> +     struct xrt_dev_ep_names *xse_names;
>>> +     /* minimum number of endpoints to support the subdevice */
>>> +     u32 xse_min_ep;
>>> +};
>>> +
>>> +/*
>>> + * struct xrt_driver - represent a xrt device driver
>>> + *
>>> + * drv: driver model structure.
>> drv vs driver?
> will fix this.
>>> + * id_table: pointer to table of device IDs the driver is 
>>> interested in.
>>> + *           { } member terminated.
>> ?
>> file_ops?
> I will remove 'id_table' and  add comment as below:
>
> * driver: driver model structure.
> * subdev_id: id of the xrt device. See enum xrt_subdev_id.
> * file_ops: character device name and callbacks.
> * probe: mandatory callback for device binding.
> * remove: callback for device unbinding.
> * leaf_call: callback for servicing other leaf drivers.
>
>>> + * probe: mandatory callback for device binding.
>>> + * remove: callback for device unbinding.
>>> + */
>>> +struct xrt_driver {
>>> +     struct device_driver driver;
>>> +     u32 subdev_id;
>>> +     struct xrt_dev_file_ops file_ops;
>>> +     struct xrt_dev_endpoints *endpoints;
>>> +
>>> +     /*
>>> +      * Subdev driver callbacks populated by subdev driver.
>>> +      */
>>> +     int (*probe)(struct xrt_device *xrt_dev);
>>> +     void (*remove)(struct xrt_device *xrt_dev);
>>> +     /*
>>> +      * If leaf_call is defined, these are called by other leaf 
>>> drivers.
>>> +      * Note that root driver may call into leaf_call of a group 
>>> driver.
>>> +      */
>>> +     int (*leaf_call)(struct xrt_device *xrt_dev, u32 cmd, void *arg);
>>> +};
>>> +
>>> +#define to_xrt_dev(d) container_of(d, struct xrt_device, dev)
>>> +#define to_xrt_drv(d) container_of(d, struct xrt_driver, driver)
>>> +
>>> +static inline void *xrt_get_drvdata(const struct xrt_device *xdev)
>>> +{
>>> +     return dev_get_drvdata(&xdev->dev);
>>> +}
>>> +
>>> +static inline void xrt_set_drvdata(struct xrt_device *xdev, void 
>>> *data)
>>> +{
>>> +     dev_set_drvdata(&xdev->dev, data);
>>> +}
>>> +
>>> +static inline void *xrt_get_xdev_data(struct device *dev)
>>> +{
>>> +     struct xrt_device *xdev = to_xrt_dev(dev);
>>> +
>>> +     return xdev->sdev_data;
>>> +}
>>> +
>>> +struct xrt_device *
>>> +xrt_device_register(struct device *parent, u32 id,
>>> +                 struct resource *res, u32 res_num,
>>> +                 void *pdata, size_t data_sz);
>>> +void xrt_device_unregister(struct xrt_device *xdev);
>>> +int xrt_register_driver(struct xrt_driver *drv);
>>> +void xrt_unregister_driver(struct xrt_driver *drv);
>>> +void *xrt_get_xdev_data(struct device *dev);
>>> +struct resource *xrt_get_resource(struct xrt_device *xdev, u32 
>>> type, u32 num);
>>> +
>>> +#endif /* _XRT_DEVICE_H_ */
>>> diff --git a/drivers/fpga/xrt/include/xleaf.h 
>>> b/drivers/fpga/xrt/include/xleaf.h
>>> new file mode 100644
>>> index 000000000000..f065fc766e0f
>>> --- /dev/null
>>> +++ b/drivers/fpga/xrt/include/xleaf.h
>>> @@ -0,0 +1,205 @@
>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>> +/*
>>> + * Copyright (C) 2020-2021 Xilinx, Inc.
>>> + *
>>> + * Authors:
>>> + *    Cheng Zhen <maxz@xilinx.com>
>>> + *    Sonal Santan <sonal.santan@xilinx.com>
>>> + */
>>> +
>>> +#ifndef _XRT_XLEAF_H_
>>> +#define _XRT_XLEAF_H_
>>> +
>>> +#include <linux/mod_devicetable.h>
>>> +#include "xdevice.h"
>>> +#include "subdev_id.h"
>>> +#include "xroot.h"
>>> +#include "events.h"
>>> +
>>> +/* All subdev drivers should use below common routines to print out 
>>> msg. */
>>> +#define DEV(xdev)    (&(xdev)->dev)
>>> +#define DEV_PDATA(xdev) \
>>> +     ((struct xrt_subdev_platdata *)xrt_get_xdev_data(DEV(xdev)))
>>> +#define DEV_FILE_OPS(xdev)                           \
>>> +     (&(to_xrt_drv((xdev)->dev.driver))->file_ops)
>>> +#define FMT_PRT(prt_fn, xdev, fmt, args...)          \
>>> +     ({typeof(xdev) (_xdev) = (xdev);                \
>>> +     prt_fn(DEV(_xdev), "%s %s: " fmt,               \
>>> +     DEV_PDATA(_xdev)->xsp_root_name, __func__, ##args); })
>>> +#define xrt_err(xdev, fmt, args...) FMT_PRT(dev_err, xdev, fmt, 
>>> ##args)
>>> +#define xrt_warn(xdev, fmt, args...) FMT_PRT(dev_warn, xdev, fmt, 
>>> ##args)
>>> +#define xrt_info(xdev, fmt, args...) FMT_PRT(dev_info, xdev, fmt, 
>>> ##args)
>>> +#define xrt_dbg(xdev, fmt, args...) FMT_PRT(dev_dbg, xdev, fmt, 
>>> ##args)
>>> +
>>> +#define XRT_DEFINE_REGMAP_CONFIG(config_name) \
>>> +     static const struct regmap_config config_name = {               \
>>> +             .reg_bits = 32,                                         \
>>> +             .val_bits = 32,                                         \
>>> +             .reg_stride = 4,                                        \
>>> +             .max_register = 0x1000,                                 \
>>> +     }
>>> +
>>> +enum {
>>> +     /* Starting cmd for common leaf cmd implemented by all leaves. */
>>> +     XRT_XLEAF_COMMON_BASE = 0,
>>> +     /* Starting cmd for leaves' specific leaf cmds. */
>>> +     XRT_XLEAF_CUSTOM_BASE = 64,
>>> +};
>>> +
>>> +enum xrt_xleaf_common_leaf_cmd {
>>> +     XRT_XLEAF_EVENT = XRT_XLEAF_COMMON_BASE,
>>> +};
>>> +
>>> +/*
>>> + * Partially initialized by the parent driver, then, passed in as 
>>> subdev driver's
>>> + * platform data when creating subdev driver instance by calling 
>>> platform
>>> + * device register API (xrt_device_register_data() or the likes).
>>> + *
>>> + * Once device register API returns, platform driver framework 
>>> makes a copy of
>>> + * this buffer and maintains its life cycle. The content of the 
>>> buffer is
>>> + * completely owned by subdev driver.
>>> + *
>>> + * Thus, parent driver should be very careful when it touches this 
>>> buffer
>>> + * again once it's handed over to subdev driver. And the data 
>>> structure
>>> + * should not contain pointers pointing to buffers that is managed by
>>> + * other or parent drivers since it could have been freed before 
>>> platform
>>> + * data buffer is freed by platform driver framework.
>>> + */
>>> +struct xrt_subdev_platdata {
>>> +     /*
>>> +      * Per driver instance callback. The xdev points to the instance.
>>> +      * Should always be defined for subdev driver to get service 
>>> from root.
>>> +      */
>>> +     xrt_subdev_root_cb_t xsp_root_cb;
>>> +     void *xsp_root_cb_arg;
>>> +
>>> +     /* Something to associate w/ root for msg printing. */
>>> +     const char *xsp_root_name;
>>> +
>>> +     /*
>>> +      * Char dev support for this subdev instance.
>>> +      * Initialized by subdev driver.
>>> +      */
>>> +     struct cdev xsp_cdev;
>>> +     struct device *xsp_sysdev;
>>> +     struct mutex xsp_devnode_lock; /* devnode lock */
>>> +     struct completion xsp_devnode_comp;
>>> +     int xsp_devnode_ref;
>>> +     bool xsp_devnode_online;
>>> +     bool xsp_devnode_excl;
>>> +
>>> +     /*
>>> +      * Subdev driver specific init data. The buffer should be 
>>> embedded
>>> +      * in this data structure buffer after dtb, so that it can be 
>>> freed
>>> +      * together with platform data.
>>> +      */
>>> +     loff_t xsp_priv_off; /* Offset into this platform data buffer. */
>>> +     size_t xsp_priv_len;
>>> +
>>> +     /*
>>> +      * Populated by parent driver to describe the device tree for
>>> +      * the subdev driver to handle. Should always be last one 
>>> since it's
>>> +      * of variable length.
>>> +      */
>>> +     bool xsp_dtb_valid;
>>> +     char xsp_dtb[0];
>>> +};
>>> +
>>> +struct subdev_match_arg {
>>> +     enum xrt_subdev_id id;
>>> +     int instance;
>>> +};
>>> +
>>> +bool xleaf_has_endpoint(struct xrt_device *xdev, const char 
>>> *endpoint_name);
>>> +struct xrt_device *xleaf_get_leaf(struct xrt_device *xdev,
>>> +                               xrt_subdev_match_t cb, void *arg);
>>> +
>>> +static inline bool subdev_match(enum xrt_subdev_id id, struct 
>>> xrt_device *xdev, void *arg)
>>> +{
>>> +     const struct subdev_match_arg *a = (struct subdev_match_arg 
>>> *)arg;
>>> +     int instance = a->instance;
>>> +
>>> +     if (id != a->id)
>>> +             return false;
>>> +     if (instance != xdev->instance && instance != 
>>> XRT_INVALID_DEVICE_INST)
>>> +             return false;
>>> +     return true;
>>> +}
>>> +
>>> +static inline bool xrt_subdev_match_epname(enum xrt_subdev_id id,
>>> +                                        struct xrt_device *xdev, 
>>> void *arg)
>>> +{
>>> +     return xleaf_has_endpoint(xdev, arg);
>>> +}
>>> +
>>> +static inline struct xrt_device *
>>> +xleaf_get_leaf_by_id(struct xrt_device *xdev,
>>> +                  enum xrt_subdev_id id, int instance)
>>> +{
>>> +     struct subdev_match_arg arg = { id, instance };
>>> +
>>> +     return xleaf_get_leaf(xdev, subdev_match, &arg);
>>> +}
>>> +
>>> +static inline struct xrt_device *
>>> +xleaf_get_leaf_by_epname(struct xrt_device *xdev, const char *name)
>>> +{
>>> +     return xleaf_get_leaf(xdev, xrt_subdev_match_epname, (void 
>>> *)name);
>>> +}
>>> +
>>> +static inline int xleaf_call(struct xrt_device *tgt, u32 cmd, void 
>>> *arg)
>>> +{
>>> +     return (to_xrt_drv(tgt->dev.driver)->leaf_call)(tgt, cmd, arg);
>>> +}
>>> +
>>> +int xleaf_broadcast_event(struct xrt_device *xdev, enum xrt_events 
>>> evt, bool async);
>>> +int xleaf_create_group(struct xrt_device *xdev, char *dtb);
>>> +int xleaf_destroy_group(struct xrt_device *xdev, int instance);
>>> +void xleaf_get_root_res(struct xrt_device *xdev, u32 region_id, 
>>> struct resource **res);
>>> +void xleaf_get_root_id(struct xrt_device *xdev, unsigned short 
>>> *vendor, unsigned short *device,
>>> +                    unsigned short *subvendor, unsigned short 
>>> *subdevice);
>>> +void xleaf_hot_reset(struct xrt_device *xdev);
>>> +int xleaf_put_leaf(struct xrt_device *xdev, struct xrt_device *leaf);
>>> +struct device *xleaf_register_hwmon(struct xrt_device *xdev, const 
>>> char *name, void *drvdata,
>>> +                                 const struct attribute_group **grps);
>>> +void xleaf_unregister_hwmon(struct xrt_device *xdev, struct device 
>>> *hwmon);
>>> +int xleaf_wait_for_group_bringup(struct xrt_device *xdev);
>>> +
>>> +/*
>>> + * Character device helper APIs for use by leaf drivers
>>> + */
>>> +static inline bool xleaf_devnode_enabled(struct xrt_device *xdev)
>>> +{
>>> +     return DEV_FILE_OPS(xdev)->xsf_ops.open;
>>> +}
>>> +
>>> +int xleaf_devnode_create(struct xrt_device *xdev,
>>> +                      const char *file_name, const char *inst_name);
>>> +void xleaf_devnode_destroy(struct xrt_device *xdev);
>>> +
>>> +struct xrt_device *xleaf_devnode_open_excl(struct inode *inode);
>>> +struct xrt_device *xleaf_devnode_open(struct inode *inode);
>>> +void xleaf_devnode_close(struct inode *inode);
>>> +
>>> +/* Module's init/fini routines for leaf driver in xrt-lib module */
>>> +#define XRT_LEAF_INIT_FINI_FUNC(name) \
>>> +void name##_leaf_init_fini(bool 
>>> init)                                        \
>>> +{                                                                    \
>>> +     if (init)                                                       \
>>> + xrt_register_driver(&xrt_##name##_driver);              \
>>> + else \
>>> + xrt_unregister_driver(&xrt_##name##_driver);            \
>>> +}
>>> +
>>> +/* Module's init/fini routines for leaf driver in xrt-lib module */
>>> +void group_leaf_init_fini(bool init);
>>> +void vsec_leaf_init_fini(bool init);
>>> +void devctl_leaf_init_fini(bool init);
>>> +void axigate_leaf_init_fini(bool init);
>>> +void icap_leaf_init_fini(bool init);
>>> +void calib_leaf_init_fini(bool init);
>>> +void clkfreq_leaf_init_fini(bool init);
>>> +void clock_leaf_init_fini(bool init);
>>> +void ucs_leaf_init_fini(bool init);
>>> +
>>> +#endif       /* _XRT_LEAF_H_ */
>>> diff --git a/drivers/fpga/xrt/include/xleaf/clkfreq.h 
>>> b/drivers/fpga/xrt/include/xleaf/clkfreq.h
>>> new file mode 100644
>>> index 000000000000..005441d5df78
>>> --- /dev/null
>>> +++ b/drivers/fpga/xrt/include/xleaf/clkfreq.h
>>> @@ -0,0 +1,21 @@
>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>> +/*
>>> + * Copyright (C) 2020-2021 Xilinx, Inc.
>>> + *
>>> + * Authors:
>>> + *   Lizhi Hou <Lizhi.Hou@xilinx.com>
>>> + */
>>> +
>>> +#ifndef _XRT_CLKFREQ_H_
>>> +#define _XRT_CLKFREQ_H_
>>> +
>>> +#include "xleaf.h"
>>> +
>>> +/*
>>> + * CLKFREQ driver leaf calls.
>>> + */
>>> +enum xrt_clkfreq_leaf_cmd {
>>> +     XRT_CLKFREQ_READ = XRT_XLEAF_CUSTOM_BASE, /* See comments in 
>>> xleaf.h */
>>> +};
>>> +
>>> +#endif       /* _XRT_CLKFREQ_H_ */
>>> diff --git a/drivers/fpga/xrt/include/xleaf/clock.h 
>>> b/drivers/fpga/xrt/include/xleaf/clock.h
>>> new file mode 100644
>>> index 000000000000..1379e24fa5d0
>>> --- /dev/null
>>> +++ b/drivers/fpga/xrt/include/xleaf/clock.h
>>> @@ -0,0 +1,29 @@
>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>> +/*
>>> + * Copyright (C) 2020-2021 Xilinx, Inc.
>>> + *
>>> + * Authors:
>>> + *   Lizhi Hou <Lizhi.Hou@xilinx.com>
>>> + */
>>> +
>>> +#ifndef _XRT_CLOCK_H_
>>> +#define _XRT_CLOCK_H_
>>> +
>>> +#include "xleaf.h"
>>> +#include <linux/fpga_xrt.h>
>>> +
>>> +/*
>>> + * CLOCK driver leaf calls.
>>> + */
>>> +enum xrt_clock_leaf_cmd {
>>> +     XRT_CLOCK_SET = XRT_XLEAF_CUSTOM_BASE, /* See comments in 
>>> xleaf.h */
>>> +     XRT_CLOCK_GET,
>>> +     XRT_CLOCK_VERIFY,
>>> +};
>>> +
>>> +struct xrt_clock_get {
>>> +     u16 freq;
>>> +     u32 freq_cnter;
>>> +};
>>> +
>>> +#endif       /* _XRT_CLOCK_H_ */
>>> diff --git a/drivers/fpga/xrt/include/xleaf/ddr_calibration.h 
>>> b/drivers/fpga/xrt/include/xleaf/ddr_calibration.h
>>> new file mode 100644
>>> index 000000000000..c44ae30f939a
>>> --- /dev/null
>>> +++ b/drivers/fpga/xrt/include/xleaf/ddr_calibration.h
>>> @@ -0,0 +1,28 @@
>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>> +/*
>>> + * Copyright (C) 2020-2021 Xilinx, Inc.
>>> + *
>>> + * Authors:
>>> + *   Cheng Zhen <maxz@xilinx.com>
>>> + */
>>> +
>>> +#ifndef _XRT_DDR_CALIBRATION_H_
>>> +#define _XRT_DDR_CALIBRATION_H_
>>> +
>>> +#include "xleaf.h"
>>> +#include <linux/fpga-xrt.h>
>>> +
>>> +/*
>>> + * Memory calibration driver leaf calls.
>>> + */
>>> +enum xrt_calib_results {
>>> +     XRT_CALIB_UNKNOWN = 0,
>>> +     XRT_CALIB_SUCCEEDED,
>>> +     XRT_CALIB_FAILED,
>>> +};
>>> +
>>> +enum xrt_calib_leaf_cmd {
>>> +     XRT_CALIB_RESULT = XRT_XLEAF_CUSTOM_BASE, /* See comments in 
>>> xleaf.h */
>>> +};
>>> +
>>> +#endif       /* _XRT_DDR_CALIBRATION_H_ */
>>> diff --git a/drivers/fpga/xrt/include/xleaf/devctl.h 
>>> b/drivers/fpga/xrt/include/xleaf/devctl.h
>>> new file mode 100644
>>> index 000000000000..b97f3b6d9326
>>> --- /dev/null
>>> +++ b/drivers/fpga/xrt/include/xleaf/devctl.h
>>> @@ -0,0 +1,40 @@
>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>> +/*
>>> + * Copyright (C) 2020-2021 Xilinx, Inc.
>>> + *
>>> + * Authors:
>>> + *   Lizhi Hou <Lizhi.Hou@xilinx.com>
>>> + */
>>> +
>>> +#ifndef _XRT_DEVCTL_H_
>>> +#define _XRT_DEVCTL_H_
>>> +
>>> +#include "xleaf.h"
>>> +
>>> +/*
>>> + * DEVCTL driver leaf calls.
>>> + */
>>> +enum xrt_devctl_leaf_cmd {
>>> +     XRT_DEVCTL_READ = XRT_XLEAF_CUSTOM_BASE, /* See comments in 
>>> xleaf.h */
>>> +};
>>> +
>>> +enum xrt_devctl_id {
>>> +     XRT_DEVCTL_ROM_UUID = 0,
>>> +     XRT_DEVCTL_DDR_CALIB,
>>> +     XRT_DEVCTL_GOLDEN_VER,
>>> +     XRT_DEVCTL_MAX
>>> +};
>>> +
>>> +struct xrt_devctl_rw {
>>> +     u32     xdr_id;
>>> +     void    *xdr_buf;
>>> +     u32     xdr_len;
>>> +     u32     xdr_offset;
>>> +};
>>> +
>>> +struct xrt_devctl_intf_uuid {
>>> +     u32     uuid_num;
>>> +     uuid_t  *uuids;
>>> +};
>>> +
>>> +#endif       /* _XRT_DEVCTL_H_ */
>>> diff --git a/drivers/fpga/xrt/lib/lib-drv.c 
>>> b/drivers/fpga/xrt/lib/lib-drv.c
>>> new file mode 100644
>>> index 000000000000..2c2f9fe3e07e
>>> --- /dev/null
>>> +++ b/drivers/fpga/xrt/lib/lib-drv.c
>>> @@ -0,0 +1,322 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * Copyright (C) 2020-2021 Xilinx, Inc.
>>> + *
>>> + * Authors:
>>> + *   Cheng Zhen <maxz@xilinx.com>
>>> + *   Lizhi Hou <lizhi.hou@xilinx.com>
>>> + */
>>> +
>>> +#include <linux/module.h>
>>> +#include <linux/vmalloc.h>
>>> +#include <linux/slab.h>
>>> +#include "xleaf.h"
>>> +#include "xroot.h"
>>> +#include "lib-drv.h"
>>> +
>>> +#define XRT_IPLIB_MODULE_NAME                "xrt-lib"
>>> +#define XRT_IPLIB_MODULE_VERSION     "4.0.0"
>> No driver versions ...
> I will remove the version.
>>> +#define XRT_DRVNAME(drv) ((drv)->driver.name)
>>> +
>>> +#define XRT_SUBDEV_ID_SHIFT          16
>>> +#define XRT_SUBDEV_ID_MASK           ((1 << XRT_SUBDEV_ID_SHIFT) - 1)
>>> +
>>> +struct xrt_find_drv_data {
>>> +     enum xrt_subdev_id id;
>>> +     struct xrt_driver *xdrv;
>>> +};
>>> +
>>> +struct class *xrt_class;
>>> +static DEFINE_IDA(xrt_device_ida);
>>> +
>>> +static inline u32 xrt_instance_to_id(enum xrt_subdev_id id, u32 
>>> instance)
>>> +{
>>> +     return (id << XRT_SUBDEV_ID_SHIFT) | instance;
>>> +}
>>> +
>>> +static inline u32 xrt_id_to_instance(u32 id)
>>> +{
>>> +     return (id & XRT_SUBDEV_ID_MASK);
>> Don't need braces?
> I will remove the braces.
>>> +}
>>> +
>>> +static int xrt_bus_match(struct device *dev, struct device_driver 
>>> *drv)
>>> +{
>>> +     struct xrt_device *xdev = to_xrt_dev(dev);
>>> +     struct xrt_driver *xdrv = to_xrt_drv(drv);
>>> +
>>> +     if (xdev->subdev_id == xdrv->subdev_id)
>>> +             return 1;
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +static int xrt_bus_probe(struct device *dev)
>>> +{
>>> +     struct xrt_driver *xdrv = to_xrt_drv(dev->driver);
>>> +     struct xrt_device *xdev = to_xrt_dev(dev);
>>> +
>>> +     return xdrv->probe(xdev);
>>> +}
>>> +
>>> +static int xrt_bus_remove(struct device *dev)
>>> +{
>>> +     struct xrt_driver *xdrv = to_xrt_drv(dev->driver);
>>> +     struct xrt_device *xdev = to_xrt_dev(dev);
>>> +
>>> +     if (xdrv->remove)
>>> +             xdrv->remove(xdev);
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +struct bus_type xrt_bus_type = {
>>> +     .name           = "xrt",
>>> +     .match          = xrt_bus_match,
>>> +     .probe          = xrt_bus_probe,
>>> +     .remove         = xrt_bus_remove,
>>> +};
>>> +
>>> +int xrt_register_driver(struct xrt_driver *drv)
>>> +{
>>> +     const char *drvname = XRT_DRVNAME(drv);
>>> +     int rc = 0;
>>> +
>>> +     /* Initialize dev_t for char dev node. */
>>> +     if (drv->file_ops.xsf_ops.open) {
>>> +             rc = alloc_chrdev_region(&drv->file_ops.xsf_dev_t, 0,
>>> +                                      XRT_MAX_DEVICE_NODES, drvname);
>>> +             if (rc) {
>>> +                     pr_err("failed to alloc dev minor for %s: 
>>> %d\n", drvname, rc);
>>> +                     return rc;
>>> +             }
>>> +     } else {
>>> +             drv->file_ops.xsf_dev_t = (dev_t)-1;
>>> +     }
>>> +
>>> +     drv->driver.owner = THIS_MODULE;
>>> +     drv->driver.bus = &xrt_bus_type;
>>> +
>>> +     rc = driver_register(&drv->driver);
>>> +     if (rc) {
>>> +             pr_err("register %s xrt driver failed\n", drvname);
>>> +             if (drv->file_ops.xsf_dev_t != (dev_t)-1) {
>>> + unregister_chrdev_region(drv->file_ops.xsf_dev_t,
>>> + XRT_MAX_DEVICE_NODES);
>>> +             }
>>> +             return rc;
>>> +     }
>>> +
>>> +     pr_info("%s registered successfully\n", drvname);
>>> +
>>> +     return 0;
>>> +}
>>> +EXPORT_SYMBOL_GPL(xrt_register_driver);
>>> +
>>> +void xrt_unregister_driver(struct xrt_driver *drv)
>>> +{
>>> +     driver_unregister(&drv->driver);
>>> +
>>> +     if (drv->file_ops.xsf_dev_t != (dev_t)-1)
>>> + unregister_chrdev_region(drv->file_ops.xsf_dev_t, 
>>> XRT_MAX_DEVICE_NODES);
>>> +
>>> +     pr_info("%s unregistered successfully\n", XRT_DRVNAME(drv));
>> Drop this.
> Sure.
>>> +}
>>> +EXPORT_SYMBOL_GPL(xrt_unregister_driver);
>>> +
>>> +static int __find_driver(struct device_driver *drv, void *_data)
>>> +{
>>> +     struct xrt_driver *xdrv = to_xrt_drv(drv);
>>> +     struct xrt_find_drv_data *data = _data;
>>> +
>>> +     if (xdrv->subdev_id == data->id) {
>>> +             data->xdrv = xdrv;
>>> +             return 1;
>>> +     }
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +const char *xrt_drv_name(enum xrt_subdev_id id)
>>> +{
>>> +     struct xrt_find_drv_data data = { 0 };
>>> +
>>> +     data.id = id;
>>> +     bus_for_each_drv(&xrt_bus_type, NULL, &data, __find_driver);
>>> +
>>> +     if (data.xdrv)
>>> +             return XRT_DRVNAME(data.xdrv);
>>> +
>>> +     return NULL;
>>> +}
>>> +
>>> +static int xrt_drv_get_instance(enum xrt_subdev_id id)
>>> +{
>>> +     int ret;
>>> +
>>> +     ret = ida_alloc_range(&xrt_device_ida, xrt_instance_to_id(id, 0),
>>> +                           xrt_instance_to_id(id, 
>>> XRT_MAX_DEVICE_NODES),
>>> +                           GFP_KERNEL);
>>> +     if (ret < 0)
>>> +             return ret;
>>> +
>>> +     return xrt_id_to_instance((u32)ret);
>>> +}
>>> +
>>> +static void xrt_drv_put_instance(enum xrt_subdev_id id, int instance)
>>> +{
>>> +     ida_free(&xrt_device_ida, xrt_instance_to_id(id, instance));
>>> +}
>>> +
>>> +struct xrt_dev_endpoints *xrt_drv_get_endpoints(enum xrt_subdev_id id)
>>> +{
>>> +     struct xrt_find_drv_data data = { 0 };
>>> +
>>> +     data.id = id;
>>> +     bus_for_each_drv(&xrt_bus_type, NULL, &data, __find_driver);
>>> +
>>> +     if (data.xdrv)
>>> +             return data.xdrv->endpoints;
>>> +
>>> +     return NULL;
>>> +}
>>> +
>>> +static void xrt_device_release(struct device *dev)
>>> +{
>>> +     struct xrt_device *xdev = container_of(dev, struct xrt_device, 
>>> dev);
>>> +
>>> +     kfree(xdev);
>>> +}
>>> +
>>> +void xrt_device_unregister(struct xrt_device *xdev)
>>> +{
>>> +     if (xdev->state == XRT_DEVICE_STATE_ADDED)
>>> +             device_del(&xdev->dev);
>>> +
>>> +     vfree(xdev->sdev_data);
>>> +     kfree(xdev->resource);
>>> +
>>> +     if (xdev->instance != XRT_INVALID_DEVICE_INST)
>>> +             xrt_drv_put_instance(xdev->subdev_id, xdev->instance);
>>> +
>>> +     if (xdev->dev.release == xrt_device_release)
>>> +             put_device(&xdev->dev);
>>> +}
>>> +
>>> +struct xrt_device *
>>> +xrt_device_register(struct device *parent, u32 id,
>>> +                 struct resource *res, u32 res_num,
>>> +                 void *pdata, size_t data_sz)
>>> +{
>>> +     struct xrt_device *xdev = NULL;
>>> +     int ret;
>>> +
>>> +     xdev = kzalloc(sizeof(*xdev), GFP_KERNEL);
>>> +     if (!xdev)
>>> +             return NULL;
>> Nit: return xdev
> Sure.
>>> +     xdev->instance = XRT_INVALID_DEVICE_INST;
>>> +
>>> +     /* Obtain dev instance number. */
>>> +     ret = xrt_drv_get_instance(id);
>>> +     if (ret < 0) {
>>> +             dev_err(parent, "failed get instance, ret %d", ret);
>>> +             goto fail;
>>> +     }
>>> +
>>> +     xdev->instance = ret;
>>> +     xdev->name = xrt_drv_name(id);
>>> +     xdev->subdev_id = id;
>>> +     device_initialize(&xdev->dev);
>>> +     xdev->dev.release = xrt_device_release;
>>> +     xdev->dev.parent = parent;
>>> +
>>> +     xdev->dev.bus = &xrt_bus_type;
>>> +     dev_set_name(&xdev->dev, "%s.%d", xdev->name, xdev->instance);
>>> +
>>> +     xdev->num_resources = res_num;
>>> +     xdev->resource = kmemdup(res, sizeof(*res) * res_num, 
>>> GFP_KERNEL);
>>> +     if (!xdev->resource)
>>> +             goto fail;
>>> +
>>> +     xdev->sdev_data = vzalloc(data_sz);
>>> +     if (!xdev->sdev_data)
>>> +             goto fail;
>> Do you need another label here? I don't see this getting cleaned up if
>> device_add() fails below ...?
> sdev_data will be cleaned up in xrt_device_unregister().
>
> Thanks,
> Lizhi
>>> +
>>> +     memcpy(xdev->sdev_data, pdata, data_sz);
>>> +
>>> +     ret = device_add(&xdev->dev);
>>> +     if (ret) {
>>> +             dev_err(parent, "failed add device, ret %d", ret);
>>> +             goto fail;
>>> +     }
>>> +     xdev->state = XRT_DEVICE_STATE_ADDED;
>>> +
>>> +     return xdev;
>>> +
>>> +fail:
>>> +     xrt_device_unregister(xdev);
>>> +     kfree(xdev);
>>> +
>>> +     return NULL;
>>> +}
>>> +
>>> +struct resource *xrt_get_resource(struct xrt_device *xdev, u32 
>>> type, u32 num)
>>> +{
>>> +     u32 i;
>>> +
>>> +     for (i = 0; i < xdev->num_resources; i++) {
>>> +             struct resource *r = &xdev->resource[i];
>>> +
>>> +             if (type == resource_type(r) && num-- == 0)
>>> +                     return r;
>>> +     }
>>> +     return NULL;
>>> +}
>>> +
>>> +/*
>>> + * Leaf driver's module init/fini callbacks. This is not a open 
>>> infrastructure for dynamic
>>> + * plugging in drivers. All drivers should be statically added.
>>> + */
>>> +static void (*leaf_init_fini_cbs[])(bool) = {
>>> +     group_leaf_init_fini,
>>> +     axigate_leaf_init_fini,
>>> +     icap_leaf_init_fini,
>>> +};
>>> +
>>> +static __init int xrt_lib_init(void)
>>> +{
>>> +     int ret;
>>> +     int i;
>>> +
>>> +     ret = bus_register(&xrt_bus_type);
>>> +     if (ret)
>>> +             return ret;
>>> +
>>> +     xrt_class = class_create(THIS_MODULE, XRT_IPLIB_MODULE_NAME);
>>> +     if (IS_ERR(xrt_class)) {
>>> +             bus_unregister(&xrt_bus_type);
>>> +             return PTR_ERR(xrt_class);
>>> +     }
>>> +
>>> +     for (i = 0; i < ARRAY_SIZE(leaf_init_fini_cbs); i++)
>>> +             leaf_init_fini_cbs[i](true);
>>> +     return 0;
>>> +}
>>> +
>>> +static __exit void xrt_lib_fini(void)
>>> +{
>>> +     int i;
>>> +
>>> +     for (i = 0; i < ARRAY_SIZE(leaf_init_fini_cbs); i++)
>>> +             leaf_init_fini_cbs[i](false);
>>> +
>>> +     class_destroy(xrt_class);
>>> +     bus_unregister(&xrt_bus_type);
>>> +}
>>> +
>>> +module_init(xrt_lib_init);
>>> +module_exit(xrt_lib_fini);
>>> +
>>> +MODULE_VERSION(XRT_IPLIB_MODULE_VERSION);
>>> +MODULE_AUTHOR("XRT Team <runtime@xilinx.com>");
>>> +MODULE_DESCRIPTION("Xilinx Alveo IP Lib driver");
>>> +MODULE_LICENSE("GPL v2");
>>> diff --git a/drivers/fpga/xrt/lib/lib-drv.h 
>>> b/drivers/fpga/xrt/lib/lib-drv.h
>>> new file mode 100644
>>> index 000000000000..0276c28e009f
>>> --- /dev/null
>>> +++ b/drivers/fpga/xrt/lib/lib-drv.h
>>> @@ -0,0 +1,21 @@
>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>> +/*
>>> + * Copyright (C) 2020-2021 Xilinx, Inc.
>>> + *
>>> + * Authors:
>>> + *   Cheng Zhen <maxz@xilinx.com>
>>> + */
>>> +
>>> +#ifndef _LIB_DRV_H_
>>> +#define _LIB_DRV_H_
>>> +
>>> +#include <linux/device/class.h>
>>> +#include <linux/device/bus.h>
>>> +
>>> +extern struct class *xrt_class;
>>> +extern struct bus_type xrt_bus_type;
>>> +
>>> +const char *xrt_drv_name(enum xrt_subdev_id id);
>>> +struct xrt_dev_endpoints *xrt_drv_get_endpoints(enum xrt_subdev_id 
>>> id);
>>> +
>>> +#endif       /* _LIB_DRV_H_ */
>>> -- 
>>> 2.27.0
>>>
>
