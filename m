Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23380C0793
	for <lists+linux-fpga@lfdr.de>; Fri, 27 Sep 2019 16:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbfI0OaM (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 27 Sep 2019 10:30:12 -0400
Received: from mga17.intel.com ([192.55.52.151]:45946 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727076AbfI0OaM (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 27 Sep 2019 10:30:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Sep 2019 07:30:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,555,1559545200"; 
   d="scan'208";a="196729208"
Received: from tthayer-hp-z620.an.intel.com (HELO [10.122.105.146]) ([10.122.105.146])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Sep 2019 07:30:11 -0700
Reply-To: thor.thayer@linux.intel.com
Subject: Re: [PATCH v4 1/2] fpga: fpga-mgr: Add readback support
To:     Appana Durga Kedareswara Rao <appanad@xilinx.com>,
        Moritz Fischer <mdf@kernel.org>, Alan Tull <atull@kernel.org>
Cc:     Michal Simek <michals@xilinx.com>,
        "kedare06@gmail.com" <kedare06@gmail.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Nava kishore Manne <navam@xilinx.com>,
        Siva Durga Prasad Paladugu <sivadur@xilinx.com>,
        Richard Gong <richard.gong@linux.intel.com>,
        Dinh Nguyen <dinguyen@kernel.org>
References: <1532672551-22146-1-git-send-email-appana.durga.rao@xilinx.com>
 <CANk1AXSEWcZ7Oqv5pgpwvJRyyFWk5gPtniXa7T+oe6-uywqEqA@mail.gmail.com>
 <MN2PR02MB6400CD5312983443A67DCC4EDC810@MN2PR02MB6400.namprd02.prod.outlook.com>
From:   Thor Thayer <thor.thayer@linux.intel.com>
Message-ID: <4476bf39-b665-50d8-fecd-d50687d10ca2@linux.intel.com>
Date:   Fri, 27 Sep 2019 09:32:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <MN2PR02MB6400CD5312983443A67DCC4EDC810@MN2PR02MB6400.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Kedar & Moritz,

On 9/27/19 12:13 AM, Appana Durga Kedareswara Rao wrote:
> Hi Alan,
> 
> Did you get a chance to send your framework changes to upstream?
> @Moritz Fischer: If Alan couldn't send his patch series, Can we take this patch series??
> Please let me know your thoughts on this.
> 
> Regards,
> Kedar.


I'd like to see some mechanism added as well. Our CvP driver needs a way 
to load images to the FPGA over the PCIe bus.

It wasn't clear to me from the discussion on Alan's patchset[1] that the 
debugfs was acceptable to the mainline. I'd be happy to resurrect that 
patchset with the suggested changes.

Since debugfs isn't enabled for production, are there any alternatives?

Alan sent a RFC [2] for loading FIT images through the sysfs.

The RFC described a FIT image that included FPGA image specific 
information to be included with the image (for systems running without 
device tree like our PCIe bus FPGA CvP).

Unfortunately, I believe this has the same uphill battle that the Device 
Tree Overlay patches[3] have to getting accepted.

Thor

[1] https://patchwork.kernel.org/patch/10566865/

[2] https://patchwork.kernel.org/patch/9860183/
     https://patchwork.kernel.org/patch/9860193/
     https://patchwork.kernel.org/patch/9860191/
     https://patchwork.kernel.org/patch/9860189/
     https://patchwork.kernel.org/patch/9860187/

[3] https://lore.kernel.org/patchwork/cover/511851/

>> On Fri, Jul 27, 2018 at 1:22 AM, Appana Durga Kedareswara rao
>> <appana.durga.rao@xilinx.com> wrote:
>>
>> Hi Appana,
>>
>> There should be some documentation for the debugfs added under
>> Documentation/driver-api/fpga/
>>
>> Also there are a lot of #ifdefs that were added due to the
>> CONFIG_FPGA_MGR_DEBUG_FS.  This has caused a kernel robot complaint.
>> The way to fix that is to have a separate c file for the debugfs implementation.
>> I see a lot of other kernel drivers have done it this way.  I have an
>> implementation that I haven't submitted yet, it exposes different functionality
>> (exposing the image firmware file name and writing to the image file).  It's on
>> the downstream github.com/altera-opensource repo [1].  I'll clean this up and
>> submit it to the mailing list, it may take a minute for me to get to that.
>> Once that's done, your added functionality can be a patch on top of that.
>>
>> Alan
>>
>> [1] https://github.com/altera-opensource/linux-socfpga/blob/socfpga-
>> 4.17/drivers/fpga/fpga-mgr-debugfs.c
>> https://github.com/altera-opensource/linux-socfpga/blob/socfpga-
>> 4.17/drivers/fpga/fpga-mgr-debugfs.h
>>
>>
>>> Inorder to debug issues with fpga's users would like to read the fpga
>>> configuration information.
>>> This patch adds readback support for fpga configuration data in the
>>> framework through debugfs interface.
>>>
>>> Usage:
>>>          cat /sys/kernel/debug/fpga/fpga0/image
>>>
>>> Signed-off-by: Appana Durga Kedareswara rao
>>> <appana.durga.rao@xilinx.com>
>>> ---
>>> Changes for v4:
>>> --> None.
>>> Changes for v3:
>>> --> None.
>>> Changes for v2:
>>> --> Fixed debug attribute path and name as suggested by Alan Add
>>> --> config entry for DEBUG as suggested by Alan Fixed trival coding
>>> --> style issues.
>>>
>>>   drivers/fpga/Kconfig          |  7 +++++
>>>   drivers/fpga/fpga-mgr.c       | 68
>> +++++++++++++++++++++++++++++++++++++++++++
>>>   include/linux/fpga/fpga-mgr.h |  5 ++++
>>>   3 files changed, 80 insertions(+)
>>>
>>> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig index
>>> 53d3f55..838ad4e 100644
>>> --- a/drivers/fpga/Kconfig
>>> +++ b/drivers/fpga/Kconfig
>>> @@ -11,6 +11,13 @@ menuconfig FPGA
>>>
>>>   if FPGA
>>>
>>> +config FPGA_MGR_DEBUG_FS
>>> +       tristate "FPGA Debug fs"
>>> +       select DEBUG_FS
>>> +       help
>>> +         FPGA manager debug provides support for reading fpga configuration
>>> +         information.
>>> +
>>>   config FPGA_MGR_SOCFPGA
>>>          tristate "Altera SOCFPGA FPGA Manager"
>>>          depends on ARCH_SOCFPGA || COMPILE_TEST diff --git
>>> a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c index
>>> 9939d2c..4bea860 100644
>>> --- a/drivers/fpga/fpga-mgr.c
>>> +++ b/drivers/fpga/fpga-mgr.c
>>> @@ -484,6 +484,48 @@ void fpga_mgr_put(struct fpga_manager *mgr)  }
>>> EXPORT_SYMBOL_GPL(fpga_mgr_put);
>>>
>>> +#ifdef CONFIG_FPGA_MGR_DEBUG_FS
>>> +#include <linux/debugfs.h>
>>> +
>>> +static int fpga_mgr_read(struct seq_file *s, void *data) {
>>> +       struct fpga_manager *mgr = (struct fpga_manager *)s->private;
>>> +       int ret = 0;
>>> +
>>> +       if (!mgr->mops->read)
>>> +               return -ENOENT;
>>> +
>>> +       if (!mutex_trylock(&mgr->ref_mutex))
>>> +               return -EBUSY;
>>> +
>>> +       if (mgr->state != FPGA_MGR_STATE_OPERATING) {
>>> +               ret = -EPERM;
>>> +               goto err_unlock;
>>> +       }
>>> +
>>> +       /* Read the FPGA configuration data from the fabric */
>>> +       ret = mgr->mops->read(mgr, s);
>>> +       if (ret)
>>> +               dev_err(&mgr->dev, "Error while reading configuration
>>> + data from FPGA\n");
>>> +
>>> +err_unlock:
>>> +       mutex_unlock(&mgr->ref_mutex);
>>> +
>>> +       return ret;
>>> +}
>>> +
>>> +static int fpga_mgr_read_open(struct inode *inode, struct file *file)
>>> +{
>>> +       return single_open(file, fpga_mgr_read, inode->i_private); }
>>> +
>>> +static const struct file_operations fpga_mgr_ops_image = {
>>> +       .owner = THIS_MODULE,
>>> +       .open = fpga_mgr_read_open,
>>> +       .read = seq_read,
>>> +};
>>> +#endif
>>> +
>>>   /**
>>>    * fpga_mgr_lock - Lock FPGA manager for exclusive use
>>>    * @mgr:       fpga manager
>>> @@ -581,6 +623,29 @@ int fpga_mgr_register(struct device *dev, const
>> char *name,
>>>          if (ret)
>>>                  goto error_device;
>>>
>>> +#ifdef CONFIG_FPGA_MGR_DEBUG_FS
>>> +       struct dentry *d, *parent;
>>> +
>>> +       mgr->dir = debugfs_create_dir("fpga", NULL);
>>> +       if (!mgr->dir)
>>> +               goto error_device;
>>> +
>>> +       parent = mgr->dir;
>>> +       d = debugfs_create_dir(mgr->dev.kobj.name, parent);
>>> +       if (!d) {
>>> +               debugfs_remove_recursive(parent);
>>> +               goto error_device;
>>> +       }
>>> +
>>> +       parent = d;
>>> +       d = debugfs_create_file("image", 0644, parent, mgr,
>>> +                               &fpga_mgr_ops_image);
>>> +       if (!d) {
>>> +               debugfs_remove_recursive(mgr->dir);
>>> +               goto error_device;
>>> +       }
>>> +#endif
>>> +
>>>          dev_info(&mgr->dev, "%s registered\n", mgr->name);
>>>
>>>          return 0;
>>> @@ -604,6 +669,9 @@ void fpga_mgr_unregister(struct device *dev)
>>>
>>>          dev_info(&mgr->dev, "%s %s\n", __func__, mgr->name);
>>>
>>> +#ifdef CONFIG_FPGA_MGR_DEBUG_FS
>>> +       debugfs_remove_recursive(mgr->dir);
>>> +#endif
>>>          /*
>>>           * If the low level driver provides a method for putting fpga into
>>>           * a desired state upon unregister, do it.
>>> diff --git a/include/linux/fpga/fpga-mgr.h
>>> b/include/linux/fpga/fpga-mgr.h index 3c6de23..e9e17a9 100644
>>> --- a/include/linux/fpga/fpga-mgr.h
>>> +++ b/include/linux/fpga/fpga-mgr.h
>>> @@ -114,6 +114,7 @@ struct fpga_image_info {
>>>    * @write: write count bytes of configuration data to the FPGA
>>>    * @write_sg: write the scatter list of configuration data to the FPGA
>>>    * @write_complete: set FPGA to operating state after writing is done
>>> + * @read: optional: read FPGA configuration information
>>>    * @fpga_remove: optional: Set FPGA into a specific state during driver
>> remove
>>>    * @groups: optional attribute groups.
>>>    *
>>> @@ -131,6 +132,7 @@ struct fpga_manager_ops {
>>>          int (*write_sg)(struct fpga_manager *mgr, struct sg_table *sgt);
>>>          int (*write_complete)(struct fpga_manager *mgr,
>>>                                struct fpga_image_info *info);
>>> +       int (*read)(struct fpga_manager *mgr, struct seq_file *s);
>>>          void (*fpga_remove)(struct fpga_manager *mgr);
>>>          const struct attribute_group **groups;  }; @@ -151,6 +153,9 @@
>>> struct fpga_manager {
>>>          enum fpga_mgr_states state;
>>>          const struct fpga_manager_ops *mops;
>>>          void *priv;
>>> +#ifdef CONFIG_FPGA_MGR_DEBUG_FS
>>> +       struct dentry *dir;
>>> +#endif
>>>   };
>>>
>>>   #define to_fpga_manager(d) container_of(d, struct fpga_manager, dev)
>>> --
>>> 2.7.4
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-fpga"
>>> in the body of a message to majordomo@vger.kernel.org More majordomo
>>> info at  http://vger.kernel.org/majordomo-info.html

