Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93C2D43A919
	for <lists+linux-fpga@lfdr.de>; Tue, 26 Oct 2021 02:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233433AbhJZAJb (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 25 Oct 2021 20:09:31 -0400
Received: from mail-co1nam11on2072.outbound.protection.outlook.com ([40.107.220.72]:13163
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230343AbhJZAJa (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 25 Oct 2021 20:09:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YOq7edVxRHilVhO4FoC0itqcOL/wGAy+ke5uOLFMl0FdtR6qSsEO7CRgoUvC5Y4QYBytyp1LUcFIsX58MLOTZztHABvCfLbO8aUDE2+QqfJsAatDT4dcHnMdCG8pQuReHC7wibtUlcT4SI2H02Hyygz0IDbnYqLwLVRHdoAomnxlZSg9Gj1V0HToprPTM4/FNqBkpKfQ3R7oFWsZNy7lAZWOEpPxP7jix/66KAfQM9Q/ffcFsAg9d9eKCRePIQ6+qA5Z6ivzP8CeoY7/i75jC81rfAJDptudAh/RBey8Q4dFETBRdmnuciP9lPaJXvPt9qRpVx52mXCnrXq2UQg63w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6G58yBAe7NVmaRBKYBLGeZ/fNW4Us+rsSFoLt0eb0kE=;
 b=ZgcTBsw716PJn7LK9yT9iAGo7dBEGwmyUp6cwT/aJfmJlrxVBALD1NmrXOsjYOPOSqbORirvu8Vf4qt/JpXeK8xdTyLZOmM3sMtu2JuXsdcOZO65a9RSmXVH76jP8ufMUGCM3bUV2Dw2OvuD2lqv9BzM2iAOby+dekY7qg6tzRcfUp0Fdj2HxIi5s2/kCkem+v2VHKj2qkpQ+ZcQGmlo88x9dHb0kfotDfwrQbiJiHUTImlovYfs90o9ZnRwc9vgFKrHYUQNh8GBXXw9TDmJCC3wJfeGHBy4IYr40mjpLFc326Y3168UV3ha5NT3OUsc//e3g/Q/Y6LVQf22KQIGhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=intel.com smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6G58yBAe7NVmaRBKYBLGeZ/fNW4Us+rsSFoLt0eb0kE=;
 b=CjDNhFASeem6RU/sEwL0x9gaRLGSFPRfY3Dd2O61WFm4fNokVc1vlLMnXp4/IF5uJyy3CCdkLzA9zy8B/6+Wuo6GrO6hGr7RHfyRwveA2TgNxG9FIZjc4xRQrvAh+lErG4X3qj86A1hxb040KfspUKwQ8vDodOuM8l6EKf4TLbM=
Received: from BN6PR19CA0117.namprd19.prod.outlook.com (2603:10b6:404:a0::31)
 by BL0PR02MB3889.namprd02.prod.outlook.com (2603:10b6:207:4b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Tue, 26 Oct
 2021 00:07:04 +0000
Received: from BN1NAM02FT026.eop-nam02.prod.protection.outlook.com
 (2603:10b6:404:a0:cafe::33) by BN6PR19CA0117.outlook.office365.com
 (2603:10b6:404:a0::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18 via Frontend
 Transport; Tue, 26 Oct 2021 00:07:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT026.mail.protection.outlook.com (10.13.2.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4628.18 via Frontend Transport; Tue, 26 Oct 2021 00:07:04 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 25 Oct 2021 17:07:02 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 25 Oct 2021 17:07:02 -0700
Envelope-to: matthew.gerlach@intel.com,
 hao.wu@intel.com,
 yilun.xu@intel.com,
 lgoncalv@redhat.com,
 trix@redhat.com,
 linux-kernel@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 mdf@kernel.org,
 russell.h.weight@intel.com
Received: from [10.17.2.60] (port=52458)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1mf9za-0001Qo-D9; Mon, 25 Oct 2021 17:07:02 -0700
Subject: Re: [PATCH v17 4/5] fpga: image-load: add status ioctl
To:     Russ Weight <russell.h.weight@intel.com>,
        Lizhi Hou <lizhi.hou@xilinx.com>, <mdf@kernel.org>,
        <linux-fpga@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <trix@redhat.com>, <lgoncalv@redhat.com>, <yilun.xu@intel.com>,
        <hao.wu@intel.com>, <matthew.gerlach@intel.com>
References: <20210929230025.68961-1-russell.h.weight@intel.com>
 <20210929230025.68961-5-russell.h.weight@intel.com>
 <97bb3fb5-3807-386d-d2c8-fec9c077a255@xilinx.com>
 <1e94cff5-ed53-bab7-1bb1-321ba833ea1e@intel.com>
From:   Lizhi Hou <lizhi.hou@xilinx.com>
Message-ID: <bbcb902c-49e4-75e1-6e8e-4e791d8c6537@xilinx.com>
Date:   Mon, 25 Oct 2021 17:07:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <1e94cff5-ed53-bab7-1bb1-321ba833ea1e@intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e0625bae-3b98-421f-9fe8-08d998148ada
X-MS-TrafficTypeDiagnostic: BL0PR02MB3889:
X-Microsoft-Antispam-PRVS: <BL0PR02MB38894D8C363DCD6EAB8B06EAA1849@BL0PR02MB3889.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nVKtTDt4mnFdWdBoGSZi9Emva1ePkK5J8ytWd5lOlc859RNjvj6Ks5/icVUe2QRJrUab8b0+BwE1aN2slLJC3026hShkMn7GZ7UJYhUM+iw5tuNpNW7tSczqB/mQOitbRfSswoJkbgwWQjRpMN1EM+SSY7d/24Tll8S8OjV8K/HRIaSjRpL12xmS9kX68+q4r6jxVw7YdLII8GwECuf+RnGlSfclrC/tsVAX/5mDDRiSg9RrP4/Ayrf+TQA6/ABLOJ3pXkoPRpFJbwLZlXEHwP0GNp6xVNJARwSTDZCBepcrVRwmHOYspwQNFOwLZv2mwFlRLimL0J9DMqMISTkmxN2KtxXxrx2cEo5Db/c/M0zXrN6n8RNyztAvJ6tnTWqHx7/OxSwv2jNob8VMcn8XUGcdDfgEeeEDFMrKABuJLI4uQxcZs/qVqu2sjVuLa7tAqYMYjmGp7zKPTx+uh6U/FvhILj93HrOendDnpqf6mjb+9/wR+IueKI4aTFFOulJgena7BkJvcAGAi5T/Bs18qoHQ+kBsPdgK1VUW+Vsuhys5Lgo59saXR0p9uePyJ8VdZ4vLhU9tkDQPmyd1Fd6e2YWWQGpJp9OrTSOXFH7sQ8Z+fdbU5Fui1rhQ7sxWj5MFO1mRQkRvIWU+aF6lOfs1I1pvgR/LN5WzIJA4NXnp9RBFFQxJ5z1m+axOR4Ijbt8o2rd+O2yjZqlLGeqXWLCzfmUEZep2UX/awzp7peRt/zIvo2hoeYfwybEWX1yvxpoizjhsXhQdzi9yHsVFd97N7dLEaXGXMsoKjdyxaIksBkSeYRhk5mlQdLm8A213VT4AIDWkHaKKyPMnK0wUaKNFBnc+J6ncVucS8UEPEtBsH2U=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(36840700001)(46966006)(9786002)(31696002)(70206006)(4326008)(356005)(36860700001)(110136005)(186003)(2616005)(508600001)(82310400003)(47076005)(44832011)(36756003)(70586007)(966005)(54906003)(53546011)(316002)(336012)(26005)(2906002)(31686004)(426003)(83380400001)(8936002)(8676002)(36906005)(5660300002)(7636003)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2021 00:07:04.4587
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0625bae-3b98-421f-9fe8-08d998148ada
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT026.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB3889
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 10/20/21 2:42 PM, Russ Weight wrote:
> On 10/15/21 1:22 PM, Lizhi Hou wrote:
>> On 9/29/21 4:00 PM, Russ Weight wrote:
>>> Extend the FPGA Image Load framework to include an FPGA_IMAGE_LOAD_STATUS
>>> IOCTL that can be used to monitor the progress of an ongoing image upload.
>>> The status returned includes how much data remains to be transferred, the
>>> progress of the image upload, and error information in the case of a
>>> failure.
>>>
>>> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
>>> ---
>>> v17:
>>>    - Rebased for changes to earlier patches.
>>> v16:
>>>    - Minor changes to adapt in changes in prevoius patches.
>>> v15:
>>>    - This patch is new to the patchset and provides an FPGA_IMAGE_LOAD_STATUS
>>>      IOCTL to return the current values for: remaining_size, progress,
>>>      err_progress, and err_code.
>>>    - This patch has elements of the following three patches from the previous
>>>      patch-set:
>>>        [PATCH v14 3/6] fpga: sec-mgr: expose sec-mgr update status
>>>        [PATCH v14 4/6] fpga: sec-mgr: expose sec-mgr update errors
>>>        [PATCH v14 5/6] fpga: sec-mgr: expose sec-mgr update size
>>>    - Changed file, symbol, and config names to reflect the new driver name
>>>    - There are some minor changes to locking to enable this ioctl to return
>>>      coherent data.
>>> ---
>>>    Documentation/fpga/fpga-image-load.rst |  6 +++
>>>    drivers/fpga/fpga-image-load.c         | 58 +++++++++++++++++++++-----
>>>    include/linux/fpga/fpga-image-load.h   |  1 +
>>>    include/uapi/linux/fpga-image-load.h   | 18 ++++++++
>>>    4 files changed, 73 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/Documentation/fpga/fpga-image-load.rst b/Documentation/fpga/fpga-image-load.rst
>>> index 487b5466f67c..f64f5ee473b8 100644
>>> --- a/Documentation/fpga/fpga-image-load.rst
>>> +++ b/Documentation/fpga/fpga-image-load.rst
>>> @@ -33,3 +33,9 @@ being updated. This is an exclusive operation; an attempt to start
>>>    concurrent image uploads for the same device will fail with EBUSY. An
>>>    eventfd file descriptor parameter is provided to this IOCTL. It will be
>>>    signalled at the completion of the image upload.
>>> +
>>> +FPGA_IMAGE_LOAD_STATUS:
>>> +
>>> +Collect status for an on-going image upload. The status returned includes
>>> +how much data remains to be transferred, the progress of the image upload,
>>> +and error information in the case of a failure.
>>> diff --git a/drivers/fpga/fpga-image-load.c b/drivers/fpga/fpga-image-load.c
>>> index f04dfc71c190..58373b9e8c02 100644
>>> --- a/drivers/fpga/fpga-image-load.c
>>> +++ b/drivers/fpga/fpga-image-load.c
>>> @@ -22,6 +22,22 @@ static dev_t fpga_image_devt;
>>>
>>>    #define to_image_load(d) container_of(d, struct fpga_image_load, dev)
>>>
>>> +static void fpga_image_update_progress(struct fpga_image_load *imgld,
>>> +                                      u32 new_progress)
>>> +{
>>> +       mutex_lock(&imgld->lock);
>>> +       imgld->progress = new_progress;
>>> +       mutex_unlock(&imgld->lock);
>>> +}
>>> +
>>> +static void fpga_image_set_error(struct fpga_image_load *imgld, u32 err_code)
>>> +{
>>> +       mutex_lock(&imgld->lock);
>>> +       imgld->err_progress = imgld->progress;
>>> +       imgld->err_code = err_code;
>>> +       mutex_unlock(&imgld->lock);
>>> +}
>>> +
>>>    static void fpga_image_prog_complete(struct fpga_image_load *imgld)
>>>    {
>>>           mutex_lock(&imgld->lock);
>>> @@ -38,24 +54,24 @@ static void fpga_image_do_load(struct work_struct *work)
>>>           imgld = container_of(work, struct fpga_image_load, work);
>>>
>>>           if (imgld->driver_unload) {
>>> -               imgld->err_code = FPGA_IMAGE_ERR_CANCELED;
>>> +               fpga_image_set_error(imgld, FPGA_IMAGE_ERR_CANCELED);
>>>                   goto idle_exit;
>>>           }
>>>
>>>           get_device(&imgld->dev);
>>>           if (!try_module_get(imgld->dev.parent->driver->owner)) {
>>> -               imgld->err_code = FPGA_IMAGE_ERR_BUSY;
>>> +               fpga_image_set_error(imgld, FPGA_IMAGE_ERR_BUSY);
>>>                   goto putdev_exit;
>>>           }
>>>
>>> -       imgld->progress = FPGA_IMAGE_PROG_PREPARING;
>>> +       fpga_image_update_progress(imgld, FPGA_IMAGE_PROG_PREPARING);
>>>           ret = imgld->ops->prepare(imgld, imgld->data, imgld->remaining_size);
>>>           if (ret) {
>>> -               imgld->err_code = ret;
>>> +               fpga_image_set_error(imgld, ret);
>>>                   goto modput_exit;
>>>           }
>>>
>>> -       imgld->progress = FPGA_IMAGE_PROG_WRITING;
>>> +       fpga_image_update_progress(imgld, FPGA_IMAGE_PROG_WRITING);
>>>           while (imgld->remaining_size) {
>>>                   ret = imgld->ops->write(imgld, imgld->data, offset,
>>>                                           imgld->remaining_size);
>>> @@ -65,7 +81,7 @@ static void fpga_image_do_load(struct work_struct *work)
>>>                                            "write-op wrote zero data\n");
>>>                                   ret = -FPGA_IMAGE_ERR_RW_ERROR;
>>>                           }
>>> -                       imgld->err_code = -ret;
>>> +                       fpga_image_set_error(imgld, -ret);
>>>                           goto done;
>>>                   }
>>>
>>> @@ -73,10 +89,10 @@ static void fpga_image_do_load(struct work_struct *work)
>>>                   offset += ret;
>>>           }
>>>
>>> -       imgld->progress = FPGA_IMAGE_PROG_PROGRAMMING;
>>> +       fpga_image_update_progress(imgld, FPGA_IMAGE_PROG_PROGRAMMING);
>>>           ret = imgld->ops->poll_complete(imgld);
>>>           if (ret)
>>> -               imgld->err_code = ret;
>>> +               fpga_image_set_error(imgld, ret);
>>>
>>>    done:
>>>           if (imgld->ops->cleanup)
>>> @@ -151,20 +167,42 @@ static int fpga_image_load_ioctl_write(struct fpga_image_load *imgld,
>>>           return ret;
>>>    }
>>>
>>> +static int fpga_image_load_ioctl_status(struct fpga_image_load *imgld,
>>> +                                       unsigned long arg)
>>> +{
>>> +       struct fpga_image_status status;
>>> +
>>> +       memset(&status, 0, sizeof(status));
>>> +       status.progress = imgld->progress;
>>> +       status.remaining_size = imgld->remaining_size;
>>> +       status.err_progress = imgld->err_progress;
>>> +       status.err_code = imgld->err_code;
>>> +
>>> +       if (copy_to_user((void __user *)arg, &status, sizeof(status)))
>>> +               return -EFAULT;
>>> +
>>> +       return 0;
>>> +}
>>> +
>>>    static long fpga_image_load_ioctl(struct file *filp, unsigned int cmd,
>>>                                     unsigned long arg)
>>>    {
>>>           struct fpga_image_load *imgld = filp->private_data;
>>>           int ret = -ENOTTY;
>>>
>>> +       mutex_lock(&imgld->lock);
>>> +
>>>           switch (cmd) {
>>>           case FPGA_IMAGE_LOAD_WRITE:
>>> -               mutex_lock(&imgld->lock);
>>>                   ret = fpga_image_load_ioctl_write(imgld, arg);
>>> -               mutex_unlock(&imgld->lock);
>>> +               break;
>>> +       case FPGA_IMAGE_LOAD_STATUS:
>>> +               ret = fpga_image_load_ioctl_status(imgld, arg);
>>>                   break;
>>>           }
>>>
>>> +       mutex_unlock(&imgld->lock);
>>> +
>>>           return ret;
>>>    }
>>>
>>> diff --git a/include/linux/fpga/fpga-image-load.h b/include/linux/fpga/fpga-image-load.h
>>> index 77b3c91ce073..366111d090fb 100644
>>> --- a/include/linux/fpga/fpga-image-load.h
>>> +++ b/include/linux/fpga/fpga-image-load.h
>>> @@ -49,6 +49,7 @@ struct fpga_image_load {
>>>           const u8 *data;                 /* pointer to update data */
>>>           u32 remaining_size;             /* size remaining to transfer */
>>>           u32 progress;
>>> +       u32 err_progress;               /* progress at time of error */
>>>           u32 err_code;                   /* image load error code */
>>>           bool driver_unload;
>>>           struct eventfd_ctx *finished;
>>> diff --git a/include/uapi/linux/fpga-image-load.h b/include/uapi/linux/fpga-image-load.h
>>> index 8d2d3db92e87..1b91343961df 100644
>>> --- a/include/uapi/linux/fpga-image-load.h
>>> +++ b/include/uapi/linux/fpga-image-load.h
>>> @@ -51,4 +51,22 @@ struct fpga_image_write {
>>>
>>>    #define FPGA_IMAGE_LOAD_WRITE  _IOW(FPGA_IMAGE_LOAD_MAGIC, 0, struct fpga_image_write)
>>>
>>> +/**
>>> + * FPGA_IMAGE_LOAD_STATUS - _IOR(FPGA_IMAGE_LOAD_MAGIC, 1,
>>> + *                              struct fpga_image_status)
>>> + *
>>> + * Request status information for an ongoing update.
>>> + *
>>> + * Return: 0 on success, -errno on failure.
>>> + */
>>> +struct fpga_image_status {
>>> +       /* Output */
>>> +       __u32 remaining_size;   /* size remaining to transfer */
>>> +       __u32 progress;         /* current progress of image load */
>>> +       __u32 err_progress;     /* progress at time of error */
>>> +       __u32 err_code;         /* error code */
>>> +};
>> Could this be extended to also collect the image detail?
>>
>>          Image version, name, etc been successfully written to device (flash).
>>
>>          Image version, name, etc is currently running on the device.
>>
>> Or maybe add another query command to do these?
>>
>> So the userland utility will be able to show what image is running and what image is going to run with next cold reboot.
> This status call is intended specifically to show the progress and
> status of the image load. Yilun's comments on patch 5 suggest that
> some of these types of operations could be handled as part of the
> fpga-region class driver
>
> I have patches that have not been submitted yet that contain some
> of these types of features, although not in the class driver (yet).
> Here is a link to documentation for what I have now. Take a look
> at the sysfs node descriptions that are in the control subdirectory.
> These are listed at the bottom of the file.
>
> https://github.com/OPAE/linux-dfl/blob/fpga-ofs-dev/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update

Thanks a lot. This is very helpful.

Lizhi

>
> - Russ
>
>
>>
>> Thanks,
>>
>> Lizhi
>>
>>> +
>>> +#define FPGA_IMAGE_LOAD_STATUS _IOR(FPGA_IMAGE_LOAD_MAGIC, 1, struct fpga_image_status)
>>> +
>>>    #endif /* _UAPI_LINUX_FPGA_IMAGE_LOAD_H */
>>> --
>>> 2.25.1
>>>
