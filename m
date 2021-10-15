Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99C0342FCF2
	for <lists+linux-fpga@lfdr.de>; Fri, 15 Oct 2021 22:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235258AbhJOUYr (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 15 Oct 2021 16:24:47 -0400
Received: from mail-dm6nam11on2083.outbound.protection.outlook.com ([40.107.223.83]:15521
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235134AbhJOUYq (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 15 Oct 2021 16:24:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UU+DIzCYjyI+BsWogtwouCjSexLuUp703XoBlo53S5rsNCP+F0NaySwT2V3CLPYRl2FQ3qOgQ2gVbTi0Umx7bnTuDtQZMcUkFocvMfClzY/zBymyKy3H8VlT1m671DznKwiQ0zKcnzlA3Rp6QebFJxi82oOIcX/se+/vArqHKZ9KjeDAmp1QjCWcIfhvorBUylPKeQ6bjHbiedvwZ3UBWxB9lal8ogMIVFl9sLutuHv1HOtuXrjTGYOpnCh0lw6WwRyur6ZHpnIWbmk6QkZ6nyPNAGYOLQU9AdM2R+7q8iSI47jaap/nzn+vr1B6MxCMxRnqgS8mUDuWQXj49FeUjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V2p4dUsftkXphD6GzMn7jAWbVN3NkAgMA7lFe8cn0JQ=;
 b=Oqxa6o5yIsX7TE5bcdT1/HTGNsaYvkeJUhb/nmAblT+FHyX0xQ7y6/ek1sCWLbS3PnCeYPCTyZk2zMOOBDdXGHXCvLhulcPv4PcImvk1/RoNVOTCnPtxbHgSiCGIJfc8NX4lfkXDUF2eDWrOI1zsS4fqAVhwS9eEPjBWQDBXzxJjw8w8XGZ61zHM51L9agznfvtsKdyDe0GCaB5aBlC174O4nNMPI5R+fsjQ/GBKEQmfoEr2eyO1BUeWSlA68LupwrH0DYkBD4SyChcJIU/q3ETj/vrl+0AjOIOf2yGeiWTMretFfM0NsRQQZzaO6c2bPAuChMbSQMey8v4h05g5JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=intel.com smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V2p4dUsftkXphD6GzMn7jAWbVN3NkAgMA7lFe8cn0JQ=;
 b=akqkX5dcfhnRiGQk+CcqjPYRp0b82OYI2qpm1pj8HhLSNkawIOJpGJcuMmMwinIJ1gZi60DISySU8DXXUQ4tnS4GZCdO5YC9Y/Pio8HKANy1Ytib8cjZHPPOTyHvSpH2XM0K+1VjyaGnYEgEXvdYYJqp9AIG5I8+jAgLoLAkxbk=
Received: from SN4PR0701CA0032.namprd07.prod.outlook.com
 (2603:10b6:803:2d::12) by BL3PR02MB8281.namprd02.prod.outlook.com
 (2603:10b6:208:344::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15; Fri, 15 Oct
 2021 20:22:37 +0000
Received: from SN1NAM02FT0011.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:2d:cafe::a7) by SN4PR0701CA0032.outlook.office365.com
 (2603:10b6:803:2d::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.14 via Frontend
 Transport; Fri, 15 Oct 2021 20:22:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0011.mail.protection.outlook.com (10.97.5.171) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4608.15 via Frontend Transport; Fri, 15 Oct 2021 20:22:37 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 15 Oct 2021 13:22:37 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 15 Oct 2021 13:22:37 -0700
Envelope-to: matthew.gerlach@intel.com,
 hao.wu@intel.com,
 yilun.xu@intel.com,
 lgoncalv@redhat.com,
 trix@redhat.com,
 linux-kernel@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 mdf@kernel.org,
 russell.h.weight@intel.com
Received: from [10.17.2.60] (port=39118)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1mbTiv-000Gok-0L; Fri, 15 Oct 2021 13:22:37 -0700
Subject: Re: [PATCH v17 4/5] fpga: image-load: add status ioctl
To:     Russ Weight <russell.h.weight@intel.com>, <mdf@kernel.org>,
        <linux-fpga@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <trix@redhat.com>, <lgoncalv@redhat.com>, <yilun.xu@intel.com>,
        <hao.wu@intel.com>, <matthew.gerlach@intel.com>
References: <20210929230025.68961-1-russell.h.weight@intel.com>
 <20210929230025.68961-5-russell.h.weight@intel.com>
From:   Lizhi Hou <lizhi.hou@xilinx.com>
Message-ID: <97bb3fb5-3807-386d-d2c8-fec9c077a255@xilinx.com>
Date:   Fri, 15 Oct 2021 13:22:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210929230025.68961-5-russell.h.weight@intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f771efce-f305-42af-4791-08d9901987be
X-MS-TrafficTypeDiagnostic: BL3PR02MB8281:
X-Microsoft-Antispam-PRVS: <BL3PR02MB8281D27DD2C97E5D8258B7ECA1B99@BL3PR02MB8281.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u8tnJ5FVCMDSqdxmHP6SlANmi0qjk0YhILMHxiIEcrH4l4vstwM32vs4bImITdMbjCU2dGfTm/S6gCLHSnoZUcSTanennWZ0Jf94l6zgthXVkYpDwvShtKGfQmCJzSujR+sFmmEHXyiYsDXnnPlzWch1SVmKcO/dx2KlF8QpFoRa/dMiOtoLcEPanGQYpFtTs6tBhWhPDX+9m5IZQe0ctZv5jY6Pq8P4ukV2oRJDvPKNjxuQaYtAIwZRJJgY5Jx3At1GixIyGDp1Px4auBJn3Vgre5WpkbII7yW9YsTdtnH64XrNlFu1h/n4yWtZQPpai88SgRJya18kzYC/6v5UACkl3yfg3ziLdkWkjLsmURstrAfw9gEVcTlLHpM6cxQJHVOqTiszM3PrfUErdpGsDsqBHqlR5XR/WmdHQoubT3d2e1+JG7IcDvg99NsFpLuEdlKOsNzaeACFiSLoN9aVeaekf/MY3dUN4+E7PJfXlim8gJgh0Y6Qz5L1ZFPctUoLj6Uh4grJBJxdkinxdW/gFbnAYc5A4l38lYnvxbAeIumyilTyT8nn57LAxU02YWY+CbW9Fmqm1iTFAA4uhGOzob8lhyeSO6W6T7XY6IFNuwNo9YCwIq8uIlnaFPNh/LiZWPZr4pwJSFbgOJApEzSIUx/i356Y2eUCab1B0i9rOzNDbfJNeid6DxE5b7TMyS/XqGLUQNtNCRgZEqbVGn4VCZS7RazDHrqWP/qgKiTu8q7i6KlUpcQjD7XrufqhLAddJ3vmO+O3vLw9ijDOYKccIw==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(46966006)(36840700001)(44832011)(26005)(47076005)(36860700001)(31686004)(7636003)(82310400003)(4326008)(70586007)(2906002)(336012)(8936002)(8676002)(53546011)(508600001)(5660300002)(316002)(36906005)(426003)(54906003)(110136005)(83380400001)(36756003)(2616005)(70206006)(9786002)(356005)(31696002)(186003)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 20:22:37.4802
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f771efce-f305-42af-4791-08d9901987be
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0011.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB8281
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 9/29/21 4:00 PM, Russ Weight wrote:
> Extend the FPGA Image Load framework to include an FPGA_IMAGE_LOAD_STATUS
> IOCTL that can be used to monitor the progress of an ongoing image upload.
> The status returned includes how much data remains to be transferred, the
> progress of the image upload, and error information in the case of a
> failure.
>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> ---
> v17:
>   - Rebased for changes to earlier patches.
> v16:
>   - Minor changes to adapt in changes in prevoius patches.
> v15:
>   - This patch is new to the patchset and provides an FPGA_IMAGE_LOAD_STATUS
>     IOCTL to return the current values for: remaining_size, progress,
>     err_progress, and err_code.
>   - This patch has elements of the following three patches from the previous
>     patch-set:
>       [PATCH v14 3/6] fpga: sec-mgr: expose sec-mgr update status
>       [PATCH v14 4/6] fpga: sec-mgr: expose sec-mgr update errors
>       [PATCH v14 5/6] fpga: sec-mgr: expose sec-mgr update size
>   - Changed file, symbol, and config names to reflect the new driver name
>   - There are some minor changes to locking to enable this ioctl to return
>     coherent data.
> ---
>   Documentation/fpga/fpga-image-load.rst |  6 +++
>   drivers/fpga/fpga-image-load.c         | 58 +++++++++++++++++++++-----
>   include/linux/fpga/fpga-image-load.h   |  1 +
>   include/uapi/linux/fpga-image-load.h   | 18 ++++++++
>   4 files changed, 73 insertions(+), 10 deletions(-)
>
> diff --git a/Documentation/fpga/fpga-image-load.rst b/Documentation/fpga/fpga-image-load.rst
> index 487b5466f67c..f64f5ee473b8 100644
> --- a/Documentation/fpga/fpga-image-load.rst
> +++ b/Documentation/fpga/fpga-image-load.rst
> @@ -33,3 +33,9 @@ being updated. This is an exclusive operation; an attempt to start
>   concurrent image uploads for the same device will fail with EBUSY. An
>   eventfd file descriptor parameter is provided to this IOCTL. It will be
>   signalled at the completion of the image upload.
> +
> +FPGA_IMAGE_LOAD_STATUS:
> +
> +Collect status for an on-going image upload. The status returned includes
> +how much data remains to be transferred, the progress of the image upload,
> +and error information in the case of a failure.
> diff --git a/drivers/fpga/fpga-image-load.c b/drivers/fpga/fpga-image-load.c
> index f04dfc71c190..58373b9e8c02 100644
> --- a/drivers/fpga/fpga-image-load.c
> +++ b/drivers/fpga/fpga-image-load.c
> @@ -22,6 +22,22 @@ static dev_t fpga_image_devt;
>
>   #define to_image_load(d) container_of(d, struct fpga_image_load, dev)
>
> +static void fpga_image_update_progress(struct fpga_image_load *imgld,
> +                                      u32 new_progress)
> +{
> +       mutex_lock(&imgld->lock);
> +       imgld->progress = new_progress;
> +       mutex_unlock(&imgld->lock);
> +}
> +
> +static void fpga_image_set_error(struct fpga_image_load *imgld, u32 err_code)
> +{
> +       mutex_lock(&imgld->lock);
> +       imgld->err_progress = imgld->progress;
> +       imgld->err_code = err_code;
> +       mutex_unlock(&imgld->lock);
> +}
> +
>   static void fpga_image_prog_complete(struct fpga_image_load *imgld)
>   {
>          mutex_lock(&imgld->lock);
> @@ -38,24 +54,24 @@ static void fpga_image_do_load(struct work_struct *work)
>          imgld = container_of(work, struct fpga_image_load, work);
>
>          if (imgld->driver_unload) {
> -               imgld->err_code = FPGA_IMAGE_ERR_CANCELED;
> +               fpga_image_set_error(imgld, FPGA_IMAGE_ERR_CANCELED);
>                  goto idle_exit;
>          }
>
>          get_device(&imgld->dev);
>          if (!try_module_get(imgld->dev.parent->driver->owner)) {
> -               imgld->err_code = FPGA_IMAGE_ERR_BUSY;
> +               fpga_image_set_error(imgld, FPGA_IMAGE_ERR_BUSY);
>                  goto putdev_exit;
>          }
>
> -       imgld->progress = FPGA_IMAGE_PROG_PREPARING;
> +       fpga_image_update_progress(imgld, FPGA_IMAGE_PROG_PREPARING);
>          ret = imgld->ops->prepare(imgld, imgld->data, imgld->remaining_size);
>          if (ret) {
> -               imgld->err_code = ret;
> +               fpga_image_set_error(imgld, ret);
>                  goto modput_exit;
>          }
>
> -       imgld->progress = FPGA_IMAGE_PROG_WRITING;
> +       fpga_image_update_progress(imgld, FPGA_IMAGE_PROG_WRITING);
>          while (imgld->remaining_size) {
>                  ret = imgld->ops->write(imgld, imgld->data, offset,
>                                          imgld->remaining_size);
> @@ -65,7 +81,7 @@ static void fpga_image_do_load(struct work_struct *work)
>                                           "write-op wrote zero data\n");
>                                  ret = -FPGA_IMAGE_ERR_RW_ERROR;
>                          }
> -                       imgld->err_code = -ret;
> +                       fpga_image_set_error(imgld, -ret);
>                          goto done;
>                  }
>
> @@ -73,10 +89,10 @@ static void fpga_image_do_load(struct work_struct *work)
>                  offset += ret;
>          }
>
> -       imgld->progress = FPGA_IMAGE_PROG_PROGRAMMING;
> +       fpga_image_update_progress(imgld, FPGA_IMAGE_PROG_PROGRAMMING);
>          ret = imgld->ops->poll_complete(imgld);
>          if (ret)
> -               imgld->err_code = ret;
> +               fpga_image_set_error(imgld, ret);
>
>   done:
>          if (imgld->ops->cleanup)
> @@ -151,20 +167,42 @@ static int fpga_image_load_ioctl_write(struct fpga_image_load *imgld,
>          return ret;
>   }
>
> +static int fpga_image_load_ioctl_status(struct fpga_image_load *imgld,
> +                                       unsigned long arg)
> +{
> +       struct fpga_image_status status;
> +
> +       memset(&status, 0, sizeof(status));
> +       status.progress = imgld->progress;
> +       status.remaining_size = imgld->remaining_size;
> +       status.err_progress = imgld->err_progress;
> +       status.err_code = imgld->err_code;
> +
> +       if (copy_to_user((void __user *)arg, &status, sizeof(status)))
> +               return -EFAULT;
> +
> +       return 0;
> +}
> +
>   static long fpga_image_load_ioctl(struct file *filp, unsigned int cmd,
>                                    unsigned long arg)
>   {
>          struct fpga_image_load *imgld = filp->private_data;
>          int ret = -ENOTTY;
>
> +       mutex_lock(&imgld->lock);
> +
>          switch (cmd) {
>          case FPGA_IMAGE_LOAD_WRITE:
> -               mutex_lock(&imgld->lock);
>                  ret = fpga_image_load_ioctl_write(imgld, arg);
> -               mutex_unlock(&imgld->lock);
> +               break;
> +       case FPGA_IMAGE_LOAD_STATUS:
> +               ret = fpga_image_load_ioctl_status(imgld, arg);
>                  break;
>          }
>
> +       mutex_unlock(&imgld->lock);
> +
>          return ret;
>   }
>
> diff --git a/include/linux/fpga/fpga-image-load.h b/include/linux/fpga/fpga-image-load.h
> index 77b3c91ce073..366111d090fb 100644
> --- a/include/linux/fpga/fpga-image-load.h
> +++ b/include/linux/fpga/fpga-image-load.h
> @@ -49,6 +49,7 @@ struct fpga_image_load {
>          const u8 *data;                 /* pointer to update data */
>          u32 remaining_size;             /* size remaining to transfer */
>          u32 progress;
> +       u32 err_progress;               /* progress at time of error */
>          u32 err_code;                   /* image load error code */
>          bool driver_unload;
>          struct eventfd_ctx *finished;
> diff --git a/include/uapi/linux/fpga-image-load.h b/include/uapi/linux/fpga-image-load.h
> index 8d2d3db92e87..1b91343961df 100644
> --- a/include/uapi/linux/fpga-image-load.h
> +++ b/include/uapi/linux/fpga-image-load.h
> @@ -51,4 +51,22 @@ struct fpga_image_write {
>
>   #define FPGA_IMAGE_LOAD_WRITE  _IOW(FPGA_IMAGE_LOAD_MAGIC, 0, struct fpga_image_write)
>
> +/**
> + * FPGA_IMAGE_LOAD_STATUS - _IOR(FPGA_IMAGE_LOAD_MAGIC, 1,
> + *                              struct fpga_image_status)
> + *
> + * Request status information for an ongoing update.
> + *
> + * Return: 0 on success, -errno on failure.
> + */
> +struct fpga_image_status {
> +       /* Output */
> +       __u32 remaining_size;   /* size remaining to transfer */
> +       __u32 progress;         /* current progress of image load */
> +       __u32 err_progress;     /* progress at time of error */
> +       __u32 err_code;         /* error code */
> +};

Could this be extended to also collect the image detail?

         Image version, name, etc been successfully written to device 
(flash).

         Image version, name, etc is currently running on the device.

Or maybe add another query command to do these?

So the userland utility will be able to show what image is running and 
what image is going to run with next cold reboot.


Thanks,

Lizhi

> +
> +#define FPGA_IMAGE_LOAD_STATUS _IOR(FPGA_IMAGE_LOAD_MAGIC, 1, struct fpga_image_status)
> +
>   #endif /* _UAPI_LINUX_FPGA_IMAGE_LOAD_H */
> --
> 2.25.1
>
