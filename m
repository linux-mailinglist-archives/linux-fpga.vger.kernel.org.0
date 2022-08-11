Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0A2590782
	for <lists+linux-fpga@lfdr.de>; Thu, 11 Aug 2022 22:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234711AbiHKUlX (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 11 Aug 2022 16:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235622AbiHKUlW (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 11 Aug 2022 16:41:22 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B79EE3C
        for <linux-fpga@vger.kernel.org>; Thu, 11 Aug 2022 13:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660250479; x=1691786479;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=/VcDSldxIoTyN/LAbrXRwoaY6Bara3KixeYHEEiT5d4=;
  b=IRWN/rUl/BY2tdknFscy2DGtgVoFhIlwaxiNisDRqqJ9i9wvdBQzfgDq
   N30tkdVe1WH6bGpynLzK22NO9eMRfOMayL7XcsHo0Y/fhvq2FegDVzvSo
   fMucbHJ975zCkRFRWC/hBAxl+rS4C8DJATuZ+eDpUaQBGd3y4s7I3EKy8
   IMOcOCQLLaiWryS7Bwt1wZjUIoyaVRK7Y/IFM4Kq0q5/vUvQ/KiRrd1uj
   R58S4h3ZzTe9M0zqov3GsgHlwpQVp2pzP6lMFdj9BP2IDIn2C7wizXJ2u
   DyJBWWQ7ZMbZQdrDbpmvITzM7jAxXx2MWTewBHFgKD9cEQlSfGUwwAaCY
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10436"; a="292251616"
X-IronPort-AV: E=Sophos;i="5.93,230,1654585200"; 
   d="scan'208";a="292251616"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2022 13:41:19 -0700
X-IronPort-AV: E=Sophos;i="5.93,230,1654585200"; 
   d="scan'208";a="581819251"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.43])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2022 13:41:18 -0700
Date:   Thu, 11 Aug 2022 13:41:25 -0700 (PDT)
From:   matthew.gerlach@linux.intel.com
X-X-Sender: mgerlach@rhweight-WRK1
To:     "Zhang, Tianfei" <tianfei.zhang@intel.com>
cc:     "Xu, Yilun" <yilun.xu@intel.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "Weight, Russell H" <russell.h.weight@intel.com>,
        "Wu, Hao" <hao.wu@intel.com>, "trix@redhat.com" <trix@redhat.com>
Subject: RE: [PATCH v3 1/2] fpga: m10bmc-sec: add sysfs to reload FPGA/BMC
 images
In-Reply-To: <BN9PR11MB5483F668B0974343C7FBFB92E3629@BN9PR11MB5483.namprd11.prod.outlook.com>
Message-ID: <alpine.DEB.2.22.394.2208111316170.821572@rhweight-WRK1>
References: <20220808053317.3627-1-tianfei.zhang@intel.com> <20220808053317.3627-2-tianfei.zhang@intel.com> <YvDeGNn5+lx6oPSt@yilunxu-OptiPlex-7050> <alpine.DEB.2.22.394.2208081510260.279137@rhweight-WRK1>
 <BN9PR11MB5483F668B0974343C7FBFB92E3629@BN9PR11MB5483.namprd11.prod.outlook.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On Tue, 9 Aug 2022, Zhang, Tianfei wrote:

>
>
>> -----Original Message-----
>> From: matthew.gerlach@linux.intel.com <matthew.gerlach@linux.intel.com>
>> Sent: Tuesday, August 9, 2022 7:39 AM
>> To: Xu, Yilun <yilun.xu@intel.com>
>> Cc: Zhang, Tianfei <tianfei.zhang@intel.com>; mdf@kernel.org; linux-
>> fpga@vger.kernel.org; lee.jones@linaro.org; Weight, Russell H
>> <russell.h.weight@intel.com>; Wu, Hao <hao.wu@intel.com>; trix@redhat.com
>> Subject: Re: [PATCH v3 1/2] fpga: m10bmc-sec: add sysfs to reload FPGA/BMC
>> images
>>
>>
>>
>> On Mon, 8 Aug 2022, Xu Yilun wrote:
>>
>>> On 2022-08-08 at 01:33:16 -0400, Tianfei Zhang wrote:
>>>> From: Russ Weight <russell.h.weight@intel.com>
>>>>
>>>> Add the available_images and image_load sysfs files. The
>>>> available_images file returns a space separated list of key words
>>>> that may be written into the image_load file. These keywords describe
>>>> an FPGA, BMC, or firmware image in FLASH or EEPROM storage that may be
>> loaded.
>>>>
>>>> The image_load sysfs file may be written with a key word to trigger a
>>>> reload of an FPGA, BMC, or firmware image from FLASH or EEPROM.
>>>>
>>>> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
>>>> Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
>>>> ---
>>>> v3:
>>>> uses regmap_update_bits() API instead of m10bmc_sys_update_bits().
>>>> v2:
>>>> adds the steps for how to use the "image_load" sysfs file.
>>>> ---
>>>>  .../sysfs-driver-intel-m10-bmc-sec-update     |  34 ++++++
>>>>  drivers/fpga/intel-m10-bmc-sec-update.c       | 105 ++++++++++++++++++
>>>>  2 files changed, 139 insertions(+)
>>>>
>>>> diff --git
>>>> a/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update
>>>> b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update
>>>> index 0a41afe0ab4c..3d8f04ca6f1b 100644
>>>> --- a/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update
>>>> +++ b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-sec-update
>>>> @@ -59,3 +59,37 @@ Contact:	Russ Weight <russell.h.weight@intel.com>
>>>>  Description:	Read only. Returns number of times the secure update
>>>>  		staging area has been flashed.
>>>>  		Format: "%u".
>>>> +
>>>> +What:		/sys/bus/platform/drivers/intel-m10bmc-sec-
>> update/.../control/available_images
>>>> +Date:		July 2022
>>>> +KernelVersion:  5.20
>>>> +Contact:	Russ Weight <russell.h.weight@intel.com>
>>>> +Description:	Read-only. This file returns a space separated list of
>>>> +		key words that may be written into the image_load file
>>>> +		described below. These keywords decribe an FPGA, BMC,
>>>> +		or firmware image in FLASH or EEPROM storage that may
>>>> +		be loaded.
>>>> +
>>>> +What:		/sys/bus/platform/drivers/intel-m10bmc-sec-
>> update/.../control/image_load
>>>> +Date:		July 2022
>>>> +KernelVersion:  5.20
>>>> +Contact:	Russ Weight <russell.h.weight@intel.com>
>>>> +Description:	Write-only. A key word may be written to this file to
>>>> +		trigger a reload of an FPGA, BMC, or firmware image from
>>>> +		FLASH or EEPROM. Refer to the available_images file for a
>>>> +		list of supported key words for the underlying device.
>>>> +		Writing an unsupported string to this file will result in
>>>> +		EINVAL being returned.
>>>> +		It should remove all of resources related to the old FPGA/BMC
>>>> +		image before trigger the image reload otherwise the host system
>>>> +		may crash. We recommended that follow the below steps or
>> directly
>>>
>>> I suggest we solve this concern first before other detailed refinements.
>
> I have run the stress test on N3000 and N6000 card by only directly write string to " image_load"  sysfs file,
> and observed  that there are no Host System crash occurred, but the BMC functionality failed, I think this is
> the expected behavior  that is why we strongly recommended that end-user use our RSU script or follow our
> provided steps.
>
>>>
>>> My opinion is, don't make the sysfs interface dependent of other user
>>> interfaces, like the following:
>>>
>>>> +		use the OPAE RSU script to perform the reload for FPGA/BMC
>> image.
>>>> +		Here is the steps to trigger the reload for FPGA/BMC image:
>>>> +		1. disable the AER of the FPGA card.
>>>> +		2. unbind the PFs/VFs which have bound with VFIO/UIO driver.
>>>> +		3. trigger image reload via "image_load" sysfs file.
>>>> +		4. remove all of PCI devices of the FPGA card via
>>>> +		"/sys/bus/pci/devices/xxxx/remove" sysfs file.
>>>> +		5. wait 10 seconds.
>>>> +		6. re-scan the PCI bus via "/sys/bus/pci/rescan" sysfs file.
>>>> +	        7. enable the AER of the FPGA card.
>>>
>>> It is not a good idea the writing of the sysfs node crashes the
>>> system, if we don't follow the whole steps.
>>>
>>> Thanks,
>>> Yilun
>>
>> Hi Yilun,
>>
>> The use case being supported with this trigger is the ability to reconfigure a FPGA or
>> other programmable componenet on a board without the requiring the HW platform
>> be able to power cycle a PCI slot or power cycling the whole system.  Unfortunately,
>> when a FPGA connected to a PCI bus is reconfigured, it can cause a PCI error.  The
>> actual pci error, if any, and any mitigation steps to handle the error is platform
>> specific and dependent on the FPGA image itself.  Therefore predicting and
>> implementing all necessary error mitigation in the kernel as part of the trigger would
>> be an impossible task.
>
> I agree with Matthew's comment.
> How about we change the documentation as below:
>
> It should remove all of resources related to the old FPGA/BMC
> image before trigger the image reload otherwise the functionalities
> of FPGA/BMC will fail. We recommended that follow the below steps
> or directly use the OPAE RSU script to perform the reload for FPGA/BMC
> image.
> Here is the steps to trigger the reload for FPGA/BMC image:
> 1. disable the AER of the FPGA card.
> 2. unbind the PFs/VFs which have bound with VFIO/UIO driver.
> 3. trigger image reload via "image_load" sysfs file.
> 4. remove all of PCI devices of the FPGA card via
> "/sys/bus/pci/devices/xxxx/remove" sysfs file.
> 5. wait 10 seconds.
> 6. re-scan the PCI bus via "/sys/bus/pci/rescan" sysfs file.
> 7. enable the AER of the FPGA card.
>

Hi Tianfei,

I think the safe sequence you describe can be made more robust as follows:

1. Unbind driver from all VFs to be affected by the trigger.
2. Shutdown all VFs from step 1.
3. Unbind driver from all PFs affectected by the trigger except the 
management PF.
4. Disable AER on all PFs and upstream pci root port.
5. trigger image reload of FPGA and/or other programmable devices
6. Unbind driver from management PF
7. Wait for reconfiguration of FPGA an/or other programmable parts (e.g. 
10 seconds)
8. re-scan PCI bus.
9. renable the AER on all PFs and upstream root port
10. bring up VFs as desired.

All of the steps above, except step 5, is easily performed in user space. 
The exact offset of the trigger register and the method to access it are
board specific.  These board differences are already handled in the 
intel-m10-bmc framework, which makes it possible to provide a consistent 
user interface accross the different boards for triggering the 
reconfiguration.

Matthew

>
>
>>
>> Matthew
>>
>>>
>>>> diff --git a/drivers/fpga/intel-m10-bmc-sec-update.c b/drivers/fpga/intel-m10-
>> bmc-sec-update.c
>>>> index 72c677c910de..3a082911cf67 100644
>>>> --- a/drivers/fpga/intel-m10-bmc-sec-update.c
>>>> +++ b/drivers/fpga/intel-m10-bmc-sec-update.c
>>>> @@ -14,6 +14,8 @@
>>>>  #include <linux/platform_device.h>
>>>>  #include <linux/slab.h>
>>>>
>>>> +struct image_load;
>>>> +
>>>>  struct m10bmc_sec {
>>>>  	struct device *dev;
>>>>  	struct intel_m10bmc *m10bmc;
>>>> @@ -21,6 +23,12 @@ struct m10bmc_sec {
>>>>  	char *fw_name;
>>>>  	u32 fw_name_id;
>>>>  	bool cancel_request;
>>>> +	struct image_load *image_load;	/* terminated with { } member */
>>>> +};
>>>> +
>>>> +struct image_load {
>>>> +	const char *name;
>>>> +	int (*load_image)(struct m10bmc_sec *sec);
>>>>  };
>>>>
>>>>  static DEFINE_XARRAY_ALLOC(fw_upload_xa);
>>>> @@ -137,6 +145,54 @@ DEVICE_ATTR_SEC_CSK_RO(pr, PR_PROG_ADDR +
>> CSK_VEC_OFFSET);
>>>>
>>>>  #define FLASH_COUNT_SIZE 4096	/* count stored as inverted bit vector */
>>>>
>>>> +static ssize_t available_images_show(struct device *dev,
>>>> +				     struct device_attribute *attr, char *buf)
>>>> +{
>>>> +	struct m10bmc_sec *sec = dev_get_drvdata(dev);
>>>> +	const struct image_load *hndlr;
>>>> +	ssize_t count = 0;
>>>> +
>>>> +	for (hndlr = sec->image_load; hndlr->name; hndlr++) {
>>>> +		count += scnprintf(buf + count, PAGE_SIZE - count,
>>>> +				   "%s ", hndlr->name);
>>>> +	}
>>>> +
>>>> +	buf[count - 1] = '\n';
>>>> +
>>>> +	return count;
>>>> +}
>>>> +static DEVICE_ATTR_RO(available_images);
>>>> +
>>>> +static ssize_t image_load_store(struct device *dev,
>>>> +				struct device_attribute *attr,
>>>> +				const char *buf, size_t count)
>>>> +{
>>>> +	struct m10bmc_sec *sec = dev_get_drvdata(dev);
>>>> +	const struct image_load *hndlr;
>>>> +	int ret = -EINVAL;
>>>> +
>>>> +	for (hndlr = sec->image_load; hndlr->name; hndlr++) {
>>>> +		if (sysfs_streq(buf, hndlr->name)) {
>>>> +			ret = hndlr->load_image(sec);
>>>> +			break;
>>>> +		}
>>>> +	}
>>>> +
>>>> +	return ret ? : count;
>>>> +}
>>>> +static DEVICE_ATTR_WO(image_load);
>>>> +
>>>> +static struct attribute *m10bmc_control_attrs[] = {
>>>> +	&dev_attr_available_images.attr,
>>>> +	&dev_attr_image_load.attr,
>>>> +	NULL,
>>>> +};
>>>> +
>>>> +static struct attribute_group m10bmc_control_attr_group = {
>>>> +	.name = "control",
>>>> +	.attrs = m10bmc_control_attrs,
>>>> +};
>>>> +
>>>>  static ssize_t flash_count_show(struct device *dev,
>>>>  				struct device_attribute *attr, char *buf)
>>>>  {
>>>> @@ -195,6 +251,7 @@ static struct attribute_group
>> m10bmc_security_attr_group = {
>>>>
>>>>  static const struct attribute_group *m10bmc_sec_attr_groups[] = {
>>>>  	&m10bmc_security_attr_group,
>>>> +	&m10bmc_control_attr_group,
>>>>  	NULL,
>>>>  };
>>>>
>>>> @@ -208,6 +265,53 @@ static void log_error_regs(struct m10bmc_sec *sec, u32
>> doorbell)
>>>>  		dev_err(sec->dev, "RSU auth result: 0x%08x\n", auth_result);
>>>>  }
>>>>
>>>> +static int m10bmc_sec_bmc_image_load(struct m10bmc_sec *sec,
>>>> +				     unsigned int val)
>>>> +{
>>>> +	u32 doorbell;
>>>> +	int ret;
>>>> +
>>>> +	if (val > 1) {
>>>> +		dev_err(sec->dev, "invalid reload val = %d\n", val);
>>>> +		return -EINVAL;
>>>> +	}
>>>> +
>>>> +	ret = m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, &doorbell);
>>>> +	if (ret)
>>>> +		return ret;
>>>> +
>>>> +	if (doorbell & DRBL_REBOOT_DISABLED)
>>>> +		return -EBUSY;
>>>> +
>>>> +	return regmap_update_bits(sec->m10bmc->regmap,
>>>> +				  M10BMC_SYS_BASE + M10BMC_DOORBELL,
>>>> +				  DRBL_CONFIG_SEL | DRBL_REBOOT_REQ,
>>>> +				  FIELD_PREP(DRBL_CONFIG_SEL, val) |
>>>> +				  DRBL_REBOOT_REQ);
>>>> +}
>>>> +
>>>> +static int m10bmc_sec_bmc_image_load_0(struct m10bmc_sec *sec)
>>>> +{
>>>> +	return m10bmc_sec_bmc_image_load(sec, 0);
>>>> +}
>>>> +
>>>> +static int m10bmc_sec_bmc_image_load_1(struct m10bmc_sec *sec)
>>>> +{
>>>> +	return m10bmc_sec_bmc_image_load(sec, 1);
>>>> +}
>>>> +
>>>> +static struct image_load m10bmc_image_load_hndlrs[] = {
>>>> +	{
>>>> +		.name = "bmc_factory",
>>>> +		.load_image = m10bmc_sec_bmc_image_load_1,
>>>> +	},
>>>> +	{
>>>> +		.name = "bmc_user",
>>>> +		.load_image = m10bmc_sec_bmc_image_load_0,
>>>> +	},
>>>> +	{}
>>>> +};
>>>> +
>>>>  static enum fw_upload_err rsu_check_idle(struct m10bmc_sec *sec)
>>>>  {
>>>>  	u32 doorbell;
>>>> @@ -565,6 +669,7 @@ static int m10bmc_sec_probe(struct platform_device
>> *pdev)
>>>>  	sec->dev = &pdev->dev;
>>>>  	sec->m10bmc = dev_get_drvdata(pdev->dev.parent);
>>>>  	dev_set_drvdata(&pdev->dev, sec);
>>>> +	sec->image_load = m10bmc_image_load_hndlrs;
>>>>
>>>>  	ret = xa_alloc(&fw_upload_xa, &sec->fw_name_id, sec,
>>>>  		       xa_limit_32b, GFP_KERNEL);
>>>> --
>>>> 2.26.2
>>>>
>>>
>
