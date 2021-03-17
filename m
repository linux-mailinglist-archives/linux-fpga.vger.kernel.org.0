Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33E7333FA54
	for <lists+linux-fpga@lfdr.de>; Wed, 17 Mar 2021 22:13:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233526AbhCQVNJ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 17 Mar 2021 17:13:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37091 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231151AbhCQVMn (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 17 Mar 2021 17:12:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616015563;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d1pEKGkKPhHu8jPDov0eJ6cEYhtjlYguZvTJDFbjEOk=;
        b=MFHdw5d5VgKA+NpJTBNijWvphbX7QhTMTwMpt7jwN5olD1RyPUIiQn5QUXB5q81h/kYVTq
        +miEGjNHHR5GWZlzFEAgfoQMhW0X1GBzy8c7Oej7X2Nvd9G9Y1R7J0V/J0FKlY1/FL/5Hx
        vGdALqm8rVb4cZdY6gcxsJhgDVEeR1o=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-242-VBB3A1vENiex-uaZ-8Lepw-1; Wed, 17 Mar 2021 17:12:41 -0400
X-MC-Unique: VBB3A1vENiex-uaZ-8Lepw-1
Received: by mail-qt1-f200.google.com with SMTP id k10so25993445qte.17
        for <linux-fpga@vger.kernel.org>; Wed, 17 Mar 2021 14:12:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=d1pEKGkKPhHu8jPDov0eJ6cEYhtjlYguZvTJDFbjEOk=;
        b=OvN5lSAjkhV85rIOnDSFwTsuRtJUCyZe6ewe+HGsTa5fzpJWmMtccEFnU71HY/buJj
         Ol+LWDLbgATBAUPo4J7EODyp1LT94kb2pHyDjfrW60O//U43tdNWfwQyXvpPMp0mgLuT
         WijJtIi8mMRQybsi2JFhjIPyGeXFHBpfMvdvQJvVm1fHL8mtmRNDJTMPUM7amt1JM4VR
         DfKNMOQEJTl/Y41Wr2b/BKbo7D1x9pB3l9CT6S7RRMd/iBFxUOZ9U7qrqeubbLaBm0bs
         QRbnbY2NdH8UunB3P2OHiiOvEDsIJ2T5/am2Bn7Gp+gK6mEdyodHWM3OwZ6NvhFRRGwO
         HuDw==
X-Gm-Message-State: AOAM530YayVzG7FwH59lV85uv2TiwwVg4AAj/R06Fq9t2tecj1oinaVl
        5Ff6I+ng3LIRUVXjPyR8WBuC+z2xPXSelbStm9UsBSbtZ3dGAzG6JMoqBnb6HrHUUQCZYflru/U
        2pkjPhQj3595OJ/v06ZtwLQ==
X-Received: by 2002:a05:620a:4050:: with SMTP id i16mr1235663qko.473.1616015560657;
        Wed, 17 Mar 2021 14:12:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyifIyHd+cS7wQCr8ziJ+pmIOBr4bM3TAxS3a9xrBVH3Eu7r6VeaaXcNauxncKYt60LWS5Lfw==
X-Received: by 2002:a05:620a:4050:: with SMTP id i16mr1235616qko.473.1616015560159;
        Wed, 17 Mar 2021 14:12:40 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 85sm158607qkf.58.2021.03.17.14.12.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Mar 2021 14:12:39 -0700 (PDT)
Subject: Re: [PATCH V3 XRT Alveo 08/18] fpga: xrt: main platform driver for
 management function device
To:     Lizhi Hou <lizhi.hou@xilinx.com>, linux-kernel@vger.kernel.org
Cc:     linux-fpga@vger.kernel.org, maxz@xilinx.com,
        sonal.santan@xilinx.com, michal.simek@xilinx.com,
        stefanos@xilinx.com, devicetree@vger.kernel.org, mdf@kernel.org,
        robh@kernel.org, Max Zhen <max.zhen@xilinx.com>
References: <20210218064019.29189-1-lizhih@xilinx.com>
 <20210218064019.29189-9-lizhih@xilinx.com>
 <73132e5e-aba7-539a-d2fe-170c93387a03@redhat.com>
 <99e2caf9-609e-ba92-10c1-746aaba81012@xilinx.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <a595fe45-8edf-f911-8204-938f67597e31@redhat.com>
Date:   Wed, 17 Mar 2021 14:12:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <99e2caf9-609e-ba92-10c1-746aaba81012@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 3/16/21 2:23 PM, Lizhi Hou wrote:
> Hi Tom,
>
>
> On 02/26/2021 09:22 AM, Tom Rix wrote:
>> On 2/17/21 10:40 PM, Lizhi Hou wrote:
>>> platform driver that handles IOCTLs, such as hot reset and xclbin download.
>>>
>>> Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
>>> Signed-off-by: Max Zhen <max.zhen@xilinx.com>
>>> Signed-off-by: Lizhi Hou <lizhih@xilinx.com>
>>> ---
>>>   drivers/fpga/xrt/include/xmgmt-main.h |  37 ++
>>>   drivers/fpga/xrt/mgmt/main-impl.h     |  37 ++
>>>   drivers/fpga/xrt/mgmt/main.c          | 693 ++++++++++++++++++++++++++
>>>   include/uapi/linux/xrt/xmgmt-ioctl.h  |  46 ++
>>>   4 files changed, 813 insertions(+)
>>>   create mode 100644 drivers/fpga/xrt/include/xmgmt-main.h
>>>   create mode 100644 drivers/fpga/xrt/mgmt/main-impl.h
>>>   create mode 100644 drivers/fpga/xrt/mgmt/main.c
>>>   create mode 100644 include/uapi/linux/xrt/xmgmt-ioctl.h
>>>
>>> diff --git a/drivers/fpga/xrt/include/xmgmt-main.h b/drivers/fpga/xrt/include/xmgmt-main.h
>>> new file mode 100644
>>> index 000000000000..1216d1881f8e
>>> --- /dev/null
>>> +++ b/drivers/fpga/xrt/include/xmgmt-main.h
>>> @@ -0,0 +1,37 @@
>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>> +/*
>>> + * Header file for Xilinx Runtime (XRT) driver
>>> + *
>>> + * Copyright (C) 2020-2021 Xilinx, Inc.
>>> + *
>>> + * Authors:
>>> + *   Cheng Zhen <maxz@xilinx.com>
>>> + */
>>> +
>>> +#ifndef _XMGMT_MAIN_H_
>>> +#define _XMGMT_MAIN_H_
>>> +
>>> +#include <linux/xrt/xclbin.h>
>>> +#include "xleaf.h"
>>> +
>>> +enum xrt_mgmt_main_ioctl_cmd {
>>> +     /* section needs to be vfree'd by caller */
>>> +     XRT_MGMT_MAIN_GET_AXLF_SECTION = XRT_XLEAF_CUSTOM_BASE, /* See comments in xleaf.h */
>> the must free instructions should go with the pointer needing freeing
> Sure. Will move the free instructions.
>>> +     /* vbnv needs to be kfree'd by caller */
>>> +     XRT_MGMT_MAIN_GET_VBNV,
>>> +};
>>> +
>>> +enum provider_kind {
>>> +     XMGMT_BLP,
>>> +     XMGMT_PLP,
>>> +     XMGMT_ULP,
>> what do these three mean ?
> Will add comment
>
> /* There are three kind of partitions. Each of them is programmed independently. */
> enum provider_kind {
>         XMGMT_BLP, /* Base Logic Partition */
>         XMGMT_PLP, /* Provider Logic Partition */
>         XMGMT_ULP, /* User Logic Partition */
> };
>
looks good
>>> +};
>>> +
>>> +struct xrt_mgmt_main_ioctl_get_axlf_section {
>>> +     enum provider_kind xmmigas_axlf_kind;
>>> +     enum axlf_section_kind xmmigas_section_kind;
>>> +     void *xmmigas_section;
>>> +     u64 xmmigas_section_size;
>>> +};
>>> +
>>> +#endif       /* _XMGMT_MAIN_H_ */
>>> diff --git a/drivers/fpga/xrt/mgmt/main-impl.h b/drivers/fpga/xrt/mgmt/main-impl.h
>>  From prefix used in the functions, a better name for this file would be xmgnt.h
> Will change.
>>> new file mode 100644
>>> index 000000000000..dd1b3e3773cc
>>> --- /dev/null
>>> +++ b/drivers/fpga/xrt/mgmt/main-impl.h
>>> @@ -0,0 +1,37 @@
>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>> +/*
>>> + * Header file for Xilinx Alveo Management Function Driver
>>> + *
>>> + * Copyright (C) 2020-2021 Xilinx, Inc.
>>> + *
>>> + * Authors:
>>> + *   Lizhi Hou <Lizhi.Hou@xilinx.com>
>>> + *   Cheng Zhen <maxz@xilinx.com>
>>> + */
>>> +
>>> +#ifndef _XMGMT_MAIN_IMPL_H_
>>> +#define _XMGMT_MAIN_IMPL_H_
>>> +
>>> +#include <linux/platform_device.h>
>>> +#include "xmgmt-main.h"
>>> +
>>> +struct fpga_manager;
>>> +int xmgmt_process_xclbin(struct platform_device *pdev,
>>> +                      struct fpga_manager *fmgr,
>>> +                      const struct axlf *xclbin,
>>> +                      enum provider_kind kind);
>>> +void xmgmt_region_cleanup_all(struct platform_device *pdev);
>>> +
>>> +int bitstream_axlf_mailbox(struct platform_device *pdev, const void *xclbin);
>> the prefix should be consistent
> Will fix this.
>>> +int xmgmt_hot_reset(struct platform_device *pdev);
>>> +
>>> +/* Getting dtb for specified group. Caller should vfree returned dtb .*/
>>> +char *xmgmt_get_dtb(struct platform_device *pdev, enum provider_kind kind);
>>> +char *xmgmt_get_vbnv(struct platform_device *pdev);
>>> +int xmgmt_get_provider_uuid(struct platform_device *pdev,
>>> +                         enum provider_kind kind, uuid_t *uuid);
>>> +
>>> +int xmgmt_main_register_leaf(void);
>>> +void xmgmt_main_unregister_leaf(void);
>> is _main_ needed ?
> Will remove.
>>> +
>>> +#endif       /* _XMGMT_MAIN_IMPL_H_ */
>>> diff --git a/drivers/fpga/xrt/mgmt/main.c b/drivers/fpga/xrt/mgmt/main.c
>>> new file mode 100644
>>> index 000000000000..66ffb4e7029d
>>> --- /dev/null
>>> +++ b/drivers/fpga/xrt/mgmt/main.c
>>> @@ -0,0 +1,693 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * Xilinx Alveo FPGA MGMT PF entry point driver
>>> + *
>>> + * Copyright (C) 2020-2021 Xilinx, Inc.
>>> + *
>>> + * Authors:
>>> + *   Sonal Santan <sonals@xilinx.com>
>>> + */
>>> +
>>> +#include <linux/firmware.h>
>>> +#include <linux/uaccess.h>
>>> +#include "xclbin-helper.h"
>>> +#include "metadata.h"
>>> +#include "xleaf.h"
>>> +#include <linux/xrt/xmgmt-ioctl.h>
>>> +#include "xleaf/devctl.h"
>>> +#include "xmgmt-main.h"
>>> +#include "fmgr.h"
>>> +#include "xleaf/icap.h"
>>> +#include "xleaf/axigate.h"
>>> +#include "main-impl.h"
>>> +
>>> +#define XMGMT_MAIN "xmgmt_main"
>>> +
>>> +struct xmgmt_main {
>>> +     struct platform_device *pdev;
>>> +     struct axlf *firmware_blp;
>>> +     struct axlf *firmware_plp;
>>> +     struct axlf *firmware_ulp;
>>> +     bool flash_ready;
>>> +     bool devctl_ready;
>> could combine in a bitfield
> Will change.
>>> +     struct fpga_manager *fmgr;
>>> +     struct mutex busy_mutex; /* busy lock */
>> busy_mutex ? maybe just call this 'lock'
> Will change.
>>> +
>>> +     uuid_t *blp_intf_uuids;
>>> +     u32 blp_intf_uuid_num;
>> expand intf to interface
> Will change.
>>> +};
>>> +
>>> +/* Caller should be responsible for freeing the returned string. */
>> should be -> is
> Will fix it.
>>> +char *xmgmt_get_vbnv(struct platform_device *pdev)
>> what is 'vbnv' ?
> vbnv stands for Vendor, BoardID, Name, Version. It is a string which describes board and shell.

ok, makes sense.

please add a comment

>>> +{
>>> +     struct xmgmt_main *xmm = platform_get_drvdata(pdev);
>>> +     const char *vbnv;
>>> +     char *ret;
>>> +     int i;
>>> +
>>> +     if (xmm->firmware_plp)
>>> +             vbnv = xmm->firmware_plp->m_header.m_platformVBNV;
>>> +     else if (xmm->firmware_blp)
>>> +             vbnv = xmm->firmware_blp->m_header.m_platformVBNV;
>>> +     else
>>> +             return NULL;
>> check usage in at least VBNV_show, this return is not handled
> Will add check.
>>> +
>>> +     ret = kstrdup(vbnv, GFP_KERNEL);
>>> +     if (!ret)
>>> +             return NULL;
>>> +
>>> +     for (i = 0; i < strlen(ret); i++) {
>>> +             if (ret[i] == ':' || ret[i] == '.')
>>> +                     ret[i] = '_';
>>> +     }
>>> +     return ret;
>>> +}
>>> +
>>> +static int get_dev_uuid(struct platform_device *pdev, char *uuidstr, size_t len)
>>> +{
>>> +     char uuid[16];
>>> +     struct platform_device *devctl_leaf;
>>> +     struct xrt_devctl_ioctl_rw devctl_arg = { 0 };
>>> +     int err, i, count;
>>> +
>>> +     devctl_leaf = xleaf_get_leaf_by_epname(pdev, XRT_MD_NODE_BLP_ROM);
>>> +     if (!devctl_leaf) {
>>> +             xrt_err(pdev, "can not get %s", XRT_MD_NODE_BLP_ROM);
>>> +             return -EINVAL;
>>> +     }
>>> +
>>> +     devctl_arg.xgir_id = XRT_DEVCTL_ROM_UUID;
>>> +     devctl_arg.xgir_buf = uuid;
>>> +     devctl_arg.xgir_len = sizeof(uuid);
>>> +     devctl_arg.xgir_offset = 0;
>>> +     err = xleaf_ioctl(devctl_leaf, XRT_DEVCTL_READ, &devctl_arg);
>>> +     xleaf_put_leaf(pdev, devctl_leaf);
>>> +     if (err) {
>>> +             xrt_err(pdev, "can not get uuid: %d", err);
>>> +             return err;
>>> +     }
>>> +
>> This some strange word swapping, add a comment to explain why it is needed.
>>
>> Consider if this needs to change on a big endian host.
> Will change to use import_uuid then convert to string.
>>
>>> +     for (count = 0, i = sizeof(uuid) - sizeof(u32);
>>> +             i >= 0 && len > count; i -= sizeof(u32)) {
>>> +             count += snprintf(uuidstr + count, len - count, "%08x", *(u32 *)&uuid[i]);
>>> +     }
>>> +     return 0;
>>> +}
>>> +
>>> +int xmgmt_hot_reset(struct platform_device *pdev)
>>> +{
>>> +     int ret = xleaf_broadcast_event(pdev, XRT_EVENT_PRE_HOT_RESET, false);
>>> +
>>> +     if (ret) {
>>> +             xrt_err(pdev, "offline failed, hot reset is canceled");
>>> +             return ret;
>>> +     }
>>> +
>>> +     xleaf_hot_reset(pdev);
>>> +     xleaf_broadcast_event(pdev, XRT_EVENT_POST_HOT_RESET, false);
>>> +     return 0;
>>> +}
>>> +
>>> +static ssize_t reset_store(struct device *dev, struct device_attribute *da,
>>> +                        const char *buf, size_t count)
>>> +{
>>> +     struct platform_device *pdev = to_platform_device(dev);
>>> +
>>> +     xmgmt_hot_reset(pdev);
>>> +     return count;
>>> +}
>>> +static DEVICE_ATTR_WO(reset);
>>> +
>>> +static ssize_t VBNV_show(struct device *dev, struct device_attribute *da, char *buf)
>>> +{
>>> +     ssize_t ret;
>>> +     char *vbnv;
>>> +     struct platform_device *pdev = to_platform_device(dev);
>>> +
>>> +     vbnv = xmgmt_get_vbnv(pdev);
>>> +     ret = sprintf(buf, "%s\n", vbnv);
>> null return not handled
> Will add check.
>>> +     kfree(vbnv);
>>> +     return ret;
>>> +}
>>> +static DEVICE_ATTR_RO(VBNV);
>>> +
>>> +static ssize_t logic_uuids_show(struct device *dev, struct device_attribute *da, char *buf)
>>> +{
>> what is a logic uuid ?
> logic uuid is a unique id to identify the shell.
>>> +     ssize_t ret;
>>> +     char uuid[80];
>>> +     struct platform_device *pdev = to_platform_device(dev);
>>> +
>>> +     /* Getting UUID pointed to by VSEC, should be the same as logic UUID of BLP. */
>>> +     ret = get_dev_uuid(pdev, uuid, sizeof(uuid));
>>> +     if (ret)
>>> +             return ret;
>>> +     ret = sprintf(buf, "%s\n", uuid);
>>> +     return ret;
>>> +}
>>> +static DEVICE_ATTR_RO(logic_uuids);
>>> +
>>> +static ssize_t interface_uuids_show(struct device *dev, struct device_attribute *da, char *buf)
>>> +{
>>> +     ssize_t ret = 0;
>>> +     struct platform_device *pdev = to_platform_device(dev);
>>> +     struct xmgmt_main *xmm = platform_get_drvdata(pdev);
>>> +     u32 i;
>>> +
>>> +     for (i = 0; i < xmm->blp_intf_uuid_num; i++) {
>>> +             char uuidstr[80];
>> 80 is used several places, consider making this a #define
> Will fix this.
>>> +
>>> +             xrt_md_trans_uuid2str(&xmm->blp_intf_uuids[i], uuidstr);
>>> +             ret += sprintf(buf + ret, "%s\n", uuidstr);
>>> +     }
>>> +     return ret;
>>> +}
>>> +static DEVICE_ATTR_RO(interface_uuids);
>>> +
>>> +static struct attribute *xmgmt_main_attrs[] = {
>>> +     &dev_attr_reset.attr,
>>> +     &dev_attr_VBNV.attr,
>>> +     &dev_attr_logic_uuids.attr,
>>> +     &dev_attr_interface_uuids.attr,
>>> +     NULL,
>>> +};
>>> +
>>> +/*
>>> + * sysfs hook to load xclbin primarily used for driver debug
>>> + */
>>> +static ssize_t ulp_image_write(struct file *filp, struct kobject *kobj,
>>> +                            struct bin_attribute *attr, char *buffer, loff_t off, size_t count)
>>> +{
>> off is signed, and this function assumes it is unsigned.
>>
>> this will segfault the memcpy
> Will remove ulp_image_write(). This function is not needed anymore.
>>
>>> +     struct xmgmt_main *xmm = dev_get_drvdata(container_of(kobj, struct device, kobj));
>>> +     struct axlf *xclbin;
>>> +     ulong len;
>>> +
>>> +     if (off == 0) {
>>> +             if (count < sizeof(*xclbin)) {
>>> +                     xrt_err(xmm->pdev, "count is too small %zu", count);
>>> +                     return -EINVAL;
>>> +             }
>>> +
>>> +             if (xmm->firmware_ulp) {
>> could check if the current buffer size is less than needed to avoid another alloc
>>> +                     vfree(xmm->firmware_ulp);
>>> +                     xmm->firmware_ulp = NULL;
>>> +             }
>>> +             xclbin = (struct axlf *)buffer;
>>> +             xmm->firmware_ulp = vmalloc(xclbin->m_header.m_length);
>>> +             if (!xmm->firmware_ulp)
>>> +                     return -ENOMEM;
>>> +     } else {
>>> +             xclbin = xmm->firmware_ulp;
>>> +     }
>>> +
>>> +     len = xclbin->m_header.m_length;
>>> +     if (off + count >= len && off < len) {
>> off + count > is ok ?
>>> +             memcpy(xmm->firmware_ulp + off, buffer, len - off);
>>> +             xmgmt_process_xclbin(xmm->pdev, xmm->fmgr, xmm->firmware_ulp, XMGMT_ULP);
>>> +     } else if (off + count < len) {
>>> +             memcpy(xmm->firmware_ulp + off, buffer, count);
>>> +     }
>>> +
>>> +     return count;
>>> +}
>>> +
>>> +static struct bin_attribute ulp_image_attr = {
>>> +     .attr = {
>>> +             .name = "ulp_image",
>>> +             .mode = 0200
>>> +     },
>>> +     .write = ulp_image_write,
>>> +     .size = 0
>>> +};
>>> +
>>> +static struct bin_attribute *xmgmt_main_bin_attrs[] = {
>>> +     &ulp_image_attr,
>>> +     NULL,
>>> +};
>>> +
>>> +static const struct attribute_group xmgmt_main_attrgroup = {
>>> +     .attrs = xmgmt_main_attrs,
>>> +     .bin_attrs = xmgmt_main_bin_attrs,
>>> +};
>>> +
>>> +static int load_firmware_from_flash(struct platform_device *pdev, struct axlf **fw_buf, size_t *len)
>>> +{
>>> +     return -EOPNOTSUPP;
>>> +}
>> this function is not needed, it is used only in a direct call from xmgmt_load_firmware.
>>
>> looks like it is part of an error hander which will return this NOSUPPORT error instead of the real error from load_firmware_from disk
> Will remove it.
>>> +
>>> +static int load_firmware_from_disk(struct platform_device *pdev, struct axlf **fw_buf, size_t *len)
>>> +{
>>> +     char uuid[80];
>>> +     int err = 0;
>>> +     char fw_name[256];
>>> +     const struct firmware *fw;
>>> +
>>> +     err = get_dev_uuid(pdev, uuid, sizeof(uuid));
>>> +     if (err)
>>> +             return err;
>>> +
>>> +     (void)snprintf(fw_name, sizeof(fw_name), "xilinx/%s/partition.xsabin", uuid);
>>> +     xrt_info(pdev, "try loading fw: %s", fw_name);
>>> +
>>> +     err = request_firmware(&fw, fw_name, DEV(pdev));
>>> +     if (err)
>>> +             return err;
>>> +
>>> +     *fw_buf = vmalloc(fw->size);
>>> +     *len = fw->size;
>> malloc fails but len is set ?
>>
>> better to set len to 0 on failure
> Will add check and set len to 0 on failure.
>>
>>> +     if (*fw_buf)
>>> +             memcpy(*fw_buf, fw->data, fw->size);
>>> +     else
>>> +             err = -ENOMEM;
>>> +
>>> +     release_firmware(fw);
>>> +     return 0;
>>> +}
>>> +
>>> +static const struct axlf *xmgmt_get_axlf_firmware(struct xmgmt_main *xmm, enum provider_kind kind)
>>> +{
>>> +     switch (kind) {
>>> +     case XMGMT_BLP:
>>> +             return xmm->firmware_blp;
>>> +     case XMGMT_PLP:
>>> +             return xmm->firmware_plp;
>>> +     case XMGMT_ULP:
>>> +             return xmm->firmware_ulp;
>>> +     default:
>>> +             xrt_err(xmm->pdev, "unknown axlf kind: %d", kind);
>>> +             return NULL;
>>> +     }
>>> +}
>>> +
>> needs a comment that user is responsible for freeing return
> Will add.
>>> +char *xmgmt_get_dtb(struct platform_device *pdev, enum provider_kind kind)
>>> +{
>>> +     struct xmgmt_main *xmm = platform_get_drvdata(pdev);
>>> +     char *dtb = NULL;
>>> +     const struct axlf *provider = xmgmt_get_axlf_firmware(xmm, kind);
>>> +     int rc;
>>> +
>>> +     if (!provider)
>>> +             return dtb;
>>> +
>>> +     rc = xrt_xclbin_get_metadata(DEV(pdev), provider, &dtb);
>>> +     if (rc)
>>> +             xrt_err(pdev, "failed to find dtb: %d", rc);
>>> +     return dtb;
>>> +}
>>> +
>> similar caller responsible for freeing
> Will add comment.
>>> +static const char *get_uuid_from_firmware(struct platform_device *pdev, const struct axlf *xclbin)
>>> +{
>>> +     const void *uuid = NULL;
>>> +     const void *uuiddup = NULL;
>>> +     void *dtb = NULL;
>>> +     int rc;
>>> +
>>> +     rc = xrt_xclbin_get_section(xclbin, PARTITION_METADATA, &dtb, NULL);
>>> +     if (rc)
>>> +             return NULL;
>>> +
>>> +     rc = xrt_md_get_prop(DEV(pdev), dtb, NULL, NULL, XRT_MD_PROP_LOGIC_UUID, &uuid, NULL);
>>> +     if (!rc)
>>> +             uuiddup = kstrdup(uuid, GFP_KERNEL);
>>> +     vfree(dtb);
>>> +     return uuiddup;
>>> +}
>>> +
>>> +static bool is_valid_firmware(struct platform_device *pdev,
>>> +                           const struct axlf *xclbin, size_t fw_len)
>>> +{
>>> +     const char *fw_buf = (const char *)xclbin;
>>> +     size_t axlflen = xclbin->m_header.m_length;
>>> +     const char *fw_uuid;
>>> +     char dev_uuid[80];
>>> +     int err;
>>> +
>>> +     err = get_dev_uuid(pdev, dev_uuid, sizeof(dev_uuid));
>>> +     if (err)
>>> +             return false;
>>> +
>>> +     if (memcmp(fw_buf, ICAP_XCLBIN_V2, sizeof(ICAP_XCLBIN_V2)) != 0) {
>>> +             xrt_err(pdev, "unknown fw format");
>>> +             return false;
>>> +     }
>>> +
>>> +     if (axlflen > fw_len) {
>>> +             xrt_err(pdev, "truncated fw, length: %zu, expect: %zu", fw_len, axlflen);
>>> +             return false;
>>> +     }
>>> +
>>> +     fw_uuid = get_uuid_from_firmware(pdev, xclbin);
>>> +     if (!fw_uuid || strcmp(fw_uuid, dev_uuid) != 0) {
>>> +             xrt_err(pdev, "bad fw UUID: %s, expect: %s",
>>> +                     fw_uuid ? fw_uuid : "<none>", dev_uuid);
>>> +             kfree(fw_uuid);
>>> +             return false;
>>> +     }
>>> +
>>> +     kfree(fw_uuid);
>>> +     return true;
>>> +}
>>> +
>>> +int xmgmt_get_provider_uuid(struct platform_device *pdev, enum provider_kind kind, uuid_t *uuid)
>>> +{
>>> +     struct xmgmt_main *xmm = platform_get_drvdata(pdev);
>>> +     const struct axlf *fwbuf;
>>> +     const char *fw_uuid;
>>> +     int rc = -ENOENT;
>>> +
>>> +     mutex_lock(&xmm->busy_mutex);
>>> +
>>> +     fwbuf = xmgmt_get_axlf_firmware(xmm, kind);
>>> +     if (!fwbuf)
>>> +             goto done;
>>> +
>>> +     fw_uuid = get_uuid_from_firmware(pdev, fwbuf);
>>> +     if (!fw_uuid)
>>> +             goto done;
>>> +
>>> +     rc = xrt_md_trans_str2uuid(DEV(pdev), fw_uuid, uuid);
>> should this be &fw_uuid ?
> No. fw_uuid points to the uuid string.
ok
>>> +     kfree(fw_uuid);
>>> +
>>> +done:
>>> +     mutex_unlock(&xmm->busy_mutex);
>>> +     return rc;
>>> +}
>>> +
>>> +static int xmgmt_create_blp(struct xmgmt_main *xmm)
>>> +{
>>> +     struct platform_device *pdev = xmm->pdev;
>>> +     int rc = 0;
>>> +     char *dtb = NULL;
>>> +     const struct axlf *provider = xmgmt_get_axlf_firmware(xmm, XMGMT_BLP);
>>> +
>>> +     dtb = xmgmt_get_dtb(pdev, XMGMT_BLP);
>>> +     if (dtb) {
>> not doing any work is ok ?
> Will add check for dtb.
>>> +             rc = xmgmt_process_xclbin(xmm->pdev, xmm->fmgr, provider, XMGMT_BLP);
>>> +             if (rc) {
>>> +                     xrt_err(pdev, "failed to process BLP: %d", rc);
>>> +                     goto failed;
>>> +             }
>>> +
>>> +             rc = xleaf_create_group(pdev, dtb);
>>> +             if (rc < 0)
>> why not (rc) ?
> xleaf_create_group() returns positive group id.
ok
>>> +                     xrt_err(pdev, "failed to create BLP group: %d", rc);
>>> +             else
>>> +                     rc = 0;
>>> +
>>> +             WARN_ON(xmm->blp_intf_uuids);
>> warn but not free ?
> non zero means memory leak. That will be a bug need to be fixed.
>>> +             xrt_md_get_intf_uuids(&pdev->dev, dtb, &xmm->blp_intf_uuid_num, NULL);
>>> +             if (xmm->blp_intf_uuid_num > 0) {
>>> +                     xmm->blp_intf_uuids = vzalloc(sizeof(uuid_t) * xmm->blp_intf_uuid_num);
>> unchecked alloc
> Will check.
>>> +                     xrt_md_get_intf_uuids(&pdev->dev, dtb, &xmm->blp_intf_uuid_num,
>>> +                                           xmm->blp_intf_uuids);
>>> +             }
>>> +     }
>>> +
>>> +failed:
>>> +     vfree(dtb);
>>> +     return rc;
>>> +}
>>> +
>>> +static int xmgmt_load_firmware(struct xmgmt_main *xmm)
>>> +{
>>> +     struct platform_device *pdev = xmm->pdev;
>>> +     int rc;
>>> +     size_t fwlen;
>>> +
>>> +     rc = load_firmware_from_disk(pdev, &xmm->firmware_blp, &fwlen);
>>> +     if (rc != 0)
>>> +             rc = load_firmware_from_flash(pdev, &xmm->firmware_blp, &fwlen);
>> this is the function that should be removed
> Sure.
>>> +     if (rc == 0 && is_valid_firmware(pdev, xmm->firmware_blp, fwlen))
>>> +             (void)xmgmt_create_blp(xmm);
>>> +     else
>>> +             xrt_err(pdev, "failed to find firmware, giving up: %d", rc);
>>> +     return rc;
>>> +}
>>> +
>>> +static void xmgmt_main_event_cb(struct platform_device *pdev, void *arg)
>>> +{
>>> +     struct xmgmt_main *xmm = platform_get_drvdata(pdev);
>>> +     struct xrt_event *evt = (struct xrt_event *)arg;
>>> +     enum xrt_events e = evt->xe_evt;
>>> +     enum xrt_subdev_id id = evt->xe_subdev.xevt_subdev_id;
>>> +     struct platform_device *leaf;
>>> +
>>> +     switch (e) {
>>> +     case XRT_EVENT_POST_CREATION: {
>>> +             if (id == XRT_SUBDEV_DEVCTL && !xmm->devctl_ready) {
>>> +                     leaf = xleaf_get_leaf_by_epname(pdev, XRT_MD_NODE_BLP_ROM);
>>> +                     if (leaf) {
>>> +                             xmm->devctl_ready = true;
>>> +                             xleaf_put_leaf(pdev, leaf);
>>> +                     }
>>> +             } else if (id == XRT_SUBDEV_QSPI && !xmm->flash_ready) {
>>> +                     xmm->flash_ready = true;
>>> +             } else {
>>> +                     break;
>>> +             }
>>> +
>>> +             if (xmm->devctl_ready)
>>> +                     (void)xmgmt_load_firmware(xmm);
>>> +             break;
>>> +     }
>>> +     case XRT_EVENT_PRE_REMOVAL:
>>> +             break;
>>> +     default:
>>> +             xrt_dbg(pdev, "ignored event %d", e);
>>> +             break;
>>> +     }
>>> +}
>>> +
>>> +static int xmgmt_main_probe(struct platform_device *pdev)
>>> +{
>>> +     struct xmgmt_main *xmm;
>>> +
>>> +     xrt_info(pdev, "probing...");
>>> +
>>> +     xmm = devm_kzalloc(DEV(pdev), sizeof(*xmm), GFP_KERNEL);
>>> +     if (!xmm)
>>> +             return -ENOMEM;
>>> +
>>> +     xmm->pdev = pdev;
>>> +     xmm->fmgr = xmgmt_fmgr_probe(pdev);
>>> +     if (IS_ERR(xmm->fmgr))
>>> +             return PTR_ERR(xmm->fmgr);
>>> +
>>> +     platform_set_drvdata(pdev, xmm);
>>> +     mutex_init(&xmm->busy_mutex);
>>> +
>>> +     /* Ready to handle req thru sysfs nodes. */
>>> +     if (sysfs_create_group(&DEV(pdev)->kobj, &xmgmt_main_attrgroup))
>>> +             xrt_err(pdev, "failed to create sysfs group");
>>> +     return 0;
>>> +}
>>> +
>>> +static int xmgmt_main_remove(struct platform_device *pdev)
>>> +{
>>> +     struct xmgmt_main *xmm = platform_get_drvdata(pdev);
>>> +
>>> +     /* By now, group driver should prevent any inter-leaf call. */
>>> +
>>> +     xrt_info(pdev, "leaving...");
>>> +
>>> +     vfree(xmm->blp_intf_uuids);
>>> +     vfree(xmm->firmware_blp);
>>> +     vfree(xmm->firmware_plp);
>>> +     vfree(xmm->firmware_ulp);
>>> +     xmgmt_region_cleanup_all(pdev);
>>> +     (void)xmgmt_fmgr_remove(xmm->fmgr);
>>> +     (void)sysfs_remove_group(&DEV(pdev)->kobj, &xmgmt_main_attrgroup);
>>> +     return 0;
>>> +}
>>> +
>>> +static int
>>> +xmgmt_main_leaf_ioctl(struct platform_device *pdev, u32 cmd, void *arg)
>>> +{
>>> +     struct xmgmt_main *xmm = platform_get_drvdata(pdev);
>>> +     int ret = 0;
>>> +
>>> +     switch (cmd) {
>>> +     case XRT_XLEAF_EVENT:
>>> +             xmgmt_main_event_cb(pdev, arg);
>>> +             break;
>>> +     case XRT_MGMT_MAIN_GET_AXLF_SECTION: {
>>> +             struct xrt_mgmt_main_ioctl_get_axlf_section *get =
>>> +                     (struct xrt_mgmt_main_ioctl_get_axlf_section *)arg;
>>> +             const struct axlf *firmware = xmgmt_get_axlf_firmware(xmm, get->xmmigas_axlf_kind);
>>> +
>>> +             if (!firmware) {
>>> +                     ret = -ENOENT;
>>> +             } else {
>>> +                     ret = xrt_xclbin_get_section(firmware, get->xmmigas_section_kind,
>>> +                                                  &get->xmmigas_section,
>>> +                                                  &get->xmmigas_section_size);
>>> +             }
>>> +             break;
>>> +     }
>>> +     case XRT_MGMT_MAIN_GET_VBNV: {
>>> +             char **vbnv_p = (char **)arg;
>>> +
>>> +             *vbnv_p = xmgmt_get_vbnv(pdev);
>> this can fail
> Will add check.
>>> +             break;
>>> +     }
>>> +     default:
>>> +             xrt_err(pdev, "unknown cmd: %d", cmd);
>>> +             ret = -EINVAL;
>>> +             break;
>>> +     }
>>> +     return ret;
>>> +}
>>> +
>>> +static int xmgmt_main_open(struct inode *inode, struct file *file)
>>> +{
>>> +     struct platform_device *pdev = xleaf_devnode_open(inode);
>>> +
>>> +     /* Device may have gone already when we get here. */
>>> +     if (!pdev)
>>> +             return -ENODEV;
>>> +
>>> +     xrt_info(pdev, "opened");
>>> +     file->private_data = platform_get_drvdata(pdev);
>>> +     return 0;
>>> +}
>>> +
>>> +static int xmgmt_main_close(struct inode *inode, struct file *file)
>>> +{
>>> +     struct xmgmt_main *xmm = file->private_data;
>>> +
>>> +     xleaf_devnode_close(inode);
>>> +
>>> +     xrt_info(xmm->pdev, "closed");
>>> +     return 0;
>>> +}
>>> +
>>> +/*
>>> + * Called for xclbin download xclbin load ioctl.
>>> + */
>>> +static int xmgmt_bitstream_axlf_fpga_mgr(struct xmgmt_main *xmm, void *axlf, size_t size)
>>> +{
>>> +     int ret;
>>> +
>>> +     WARN_ON(!mutex_is_locked(&xmm->busy_mutex));
>>> +
>>> +     /*
>>> +      * Should any error happens during download, we can't trust
>>> +      * the cached xclbin any more.
>>> +      */
>>> +     vfree(xmm->firmware_ulp);
>>> +     xmm->firmware_ulp = NULL;
>>> +
>>> +     ret = xmgmt_process_xclbin(xmm->pdev, xmm->fmgr, axlf, XMGMT_ULP);
>>> +     if (ret == 0)
>>> +             xmm->firmware_ulp = axlf;
>>> +
>>> +     return ret;
>>> +}
>>> +
>>> +static int bitstream_axlf_ioctl(struct xmgmt_main *xmm, const void __user *arg)
>>> +{
>>> +     void *copy_buffer = NULL;
>>> +     size_t copy_buffer_size = 0;
>>> +     struct xmgmt_ioc_bitstream_axlf ioc_obj = { 0 };
>>> +     struct axlf xclbin_obj = { {0} };
>>> +     int ret = 0;
>>> +
>>> +     if (copy_from_user((void *)&ioc_obj, arg, sizeof(ioc_obj)))
>>> +             return -EFAULT;
>>> +     if (copy_from_user((void *)&xclbin_obj, ioc_obj.xclbin, sizeof(xclbin_obj)))
>>> +             return -EFAULT;
>>> +     if (memcmp(xclbin_obj.m_magic, ICAP_XCLBIN_V2, sizeof(ICAP_XCLBIN_V2)))
>>> +             return -EINVAL;
>>> +
>>> +     copy_buffer_size = xclbin_obj.m_header.m_length;
>>> +     if (copy_buffer_size > MAX_XCLBIN_SIZE)
>>> +             return -EINVAL;
>> is there a min size ?
> Will add check.
>>> +     copy_buffer = vmalloc(copy_buffer_size);
>>> +     if (!copy_buffer)
>>> +             return -ENOMEM;
>>> +
>>> +     if (copy_from_user(copy_buffer, ioc_obj.xclbin, copy_buffer_size)) {
>>> +             vfree(copy_buffer);
>>> +             return -EFAULT;
>>> +     }
>>> +
>>> +     ret = xmgmt_bitstream_axlf_fpga_mgr(xmm, copy_buffer, copy_buffer_size);
>>> +     if (ret)
>>> +             vfree(copy_buffer);
>>> +
>>> +     return ret;
>>> +}
>>> +
>>> +static long xmgmt_main_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>>> +{
>>> +     long result = 0;
>>> +     struct xmgmt_main *xmm = filp->private_data;
>>> +
>>> +     if (_IOC_TYPE(cmd) != XMGMT_IOC_MAGIC)
>>> +             return -ENOTTY;
>>> +
>>> +     mutex_lock(&xmm->busy_mutex);
>>> +
>>> +     xrt_info(xmm->pdev, "ioctl cmd %d, arg %ld", cmd, arg);
>>> +     switch (cmd) {
>>> +     case XMGMT_IOCICAPDOWNLOAD_AXLF:
>>> +             result = bitstream_axlf_ioctl(xmm, (const void __user *)arg);
>>> +             break;
>>> +     default:
>>> +             result = -ENOTTY;
>>> +             break;
>>> +     }
>>> +
>>> +     mutex_unlock(&xmm->busy_mutex);
>>> +     return result;
>>> +}
>>> +
>>> +static struct xrt_subdev_endpoints xrt_mgmt_main_endpoints[] = {
>>> +     {
>>> +             .xse_names = (struct xrt_subdev_ep_names []){
>>> +                     { .ep_name = XRT_MD_NODE_MGMT_MAIN },
>>> +                     { NULL },
>>> +             },
>>> +             .xse_min_ep = 1,
>>> +     },
>>> +     { 0 },
>>> +};
>>> +
>>> +static struct xrt_subdev_drvdata xmgmt_main_data = {
>>> +     .xsd_dev_ops = {
>>> +             .xsd_ioctl = xmgmt_main_leaf_ioctl,
>>> +     },
>>> +     .xsd_file_ops = {
>>> +             .xsf_ops = {
>>> +                     .owner = THIS_MODULE,
>>> +                     .open = xmgmt_main_open,
>>> +                     .release = xmgmt_main_close,
>>> +                     .unlocked_ioctl = xmgmt_main_ioctl,
>>> +             },
>>> +             .xsf_dev_name = "xmgmt",
>>> +     },
>>> +};
>>> +
>>> +static const struct platform_device_id xmgmt_main_id_table[] = {
>>> +     { XMGMT_MAIN, (kernel_ulong_t)&xmgmt_main_data },
>>> +     { },
>>> +};
>>> +
>>> +static struct platform_driver xmgmt_main_driver = {
>>> +     .driver = {
>>> +             .name    = XMGMT_MAIN,
>>> +     },
>>> +     .probe   = xmgmt_main_probe,
>>> +     .remove  = xmgmt_main_remove,
>>> +     .id_table = xmgmt_main_id_table,
>>> +};
>>> +
>>> +int xmgmt_main_register_leaf(void)
>>> +{
>>> +     return xleaf_register_driver(XRT_SUBDEV_MGMT_MAIN,
>>> +                                  &xmgmt_main_driver, xrt_mgmt_main_endpoints);
>>> +}
>>> +
>>> +void xmgmt_main_unregister_leaf(void)
>>> +{
>>> +     xleaf_unregister_driver(XRT_SUBDEV_MGMT_MAIN);
>>> +}
>>> diff --git a/include/uapi/linux/xrt/xmgmt-ioctl.h b/include/uapi/linux/xrt/xmgmt-ioctl.h
>>> new file mode 100644
>>> index 000000000000..15834476f3b4
>>> --- /dev/null
>>> +++ b/include/uapi/linux/xrt/xmgmt-ioctl.h
>>> @@ -0,0 +1,46 @@
>>> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
>>> +/*
>>> + *  Copyright (C) 2015-2021, Xilinx Inc
>>> + *
>>> + */
>>> +
>>> +/**
>>> + * DOC: PCIe Kernel Driver for Managament Physical Function
>>> + * Interfaces exposed by *xclmgmt* driver are defined in file, *mgmt-ioctl.h*.
>>> + * Core functionality provided by *xmgmt* driver is described in the following table:
>>> + *
>>> + * =========== ============================== ==================================
>>> + * Functionality           ioctl request code           data format
>>> + * =========== ============================== ==================================
>>> + * 1 FPGA image download   XMGMT_IOCICAPDOWNLOAD_AXLF xmgmt_ioc_bitstream_axlf
>>> + * =========== ============================== ==================================
>>> + */
>>> +
>>> +#ifndef _XMGMT_IOCTL_H_
>>> +#define _XMGMT_IOCTL_H_
>>> +
>>> +#include <linux/ioctl.h>
>>> +
>>> +#define XMGMT_IOC_MAGIC      'X'
>>> +#define XMGMT_IOC_ICAP_DOWNLOAD_AXLF 0x6
>>> +
>>> +/**
>>> + * struct xmgmt_ioc_bitstream_axlf - load xclbin (AXLF) device image
>>> + * used with XMGMT_IOCICAPDOWNLOAD_AXLF ioctl
>>> + *
>>> + * @xclbin:  Pointer to user's xclbin structure in memory
>>> + */
>>> +struct xmgmt_ioc_bitstream_axlf {
>>> +     struct axlf *xclbin;
>> where is struct axlf defined ?
> It is defined in include/uapi/linux/xrt/xclbin.h

ok, thanks.

Tom


>
> Thanks,
> Lizhi
>>
>> Tom
>>
>>> +};
>>> +
>>> +#define XMGMT_IOCICAPDOWNLOAD_AXLF                           \
>>> +     _IOW(XMGMT_IOC_MAGIC, XMGMT_IOC_ICAP_DOWNLOAD_AXLF, struct xmgmt_ioc_bitstream_axlf)
>>> +
>>> +/*
>>> + * The following definitions are for binary compatibility with classic XRT management driver
>>> + */
>>> +#define XCLMGMT_IOCICAPDOWNLOAD_AXLF XMGMT_IOCICAPDOWNLOAD_AXLF
>>> +#define xclmgmt_ioc_bitstream_axlf xmgmt_ioc_bitstream_axlf
>>> +
>>> +#endif
>

