Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E566368DE2C
	for <lists+linux-fpga@lfdr.de>; Tue,  7 Feb 2023 17:46:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbjBGQpK (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 7 Feb 2023 11:45:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbjBGQpK (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 7 Feb 2023 11:45:10 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4927F74E;
        Tue,  7 Feb 2023 08:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675788308; x=1707324308;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hMQohETwa06WrvwGvAPs9peSNB6DruaJ7++o8QagOvI=;
  b=V93itGufZbVvk8byUQ4oWDc+2VnmTMK68vQUi1X/AQO36egEJ8KvAx3m
   2gKOsbj/ukFnhSRnh/awHWd+D3+Mx6BC/YQWEyihMXSd+Kt6zflp8jsAg
   X7DHc04WICnUZgN756riFm95+Crb2yTD5m4K45KQAsjgV6HZW3HSiZxlH
   07R7E902cSmz0v/kjN1b55J6iUPgFruFGimY+6DrCb5Y1ie1YwEc6qKWb
   dCjVlX2A30sEs9fbyW94mi/4Sqr/IZmZJDrvOCxfdLkxc1B8P6bscZQbE
   di7t0n0ZwOLz2fF04upAp9/H5KapbKfN4hfFEsf8OvKH+vap2W/xgX7W4
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="313203396"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="313203396"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2023 08:45:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="735604043"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="735604043"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga004.fm.intel.com with ESMTP; 07 Feb 2023 08:44:59 -0800
Date:   Wed, 8 Feb 2023 00:34:15 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     "Manne, Nava kishore" <nava.kishore.manne@amd.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "mdf@kernel.org" <mdf@kernel.org>,
        "hao.wu@intel.com" <hao.wu@intel.com>,
        "trix@redhat.com" <trix@redhat.com>,
        "ronak.jain@xilinx.com" <ronak.jain@xilinx.com>,
        "tanmay.shah@xilinx.com" <tanmay.shah@xilinx.com>,
        "Levinsky, Ben" <ben.levinsky@amd.com>,
        "rajan.vaja@xilinx.com" <rajan.vaja@xilinx.com>,
        "harsha.harsha@xilinx.com" <harsha.harsha@xilinx.com>,
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
        "lakshmi.sai.krishna.potthuri@xilinx.com" 
        <lakshmi.sai.krishna.potthuri@xilinx.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>
Subject: Re: [PATCH v5 2/2] fpga: zynqmp-fpga: Adds status interface
Message-ID: <Y+J9h9YUmBJduaYN@yilunxu-OptiPlex-7050>
References: <20230131094810.1945541-1-nava.kishore.manne@amd.com>
 <20230131094810.1945541-3-nava.kishore.manne@amd.com>
 <Y9j+rZQkiPcIPxOr@kroah.com>
 <DM6PR12MB39931368F0863BBBF22BC806CDDB9@DM6PR12MB3993.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR12MB39931368F0863BBBF22BC806CDDB9@DM6PR12MB3993.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2023-02-07 at 09:23:12 +0000, Manne, Nava kishore wrote:
> Hi Greg,
> 
> 	Thanks for providing the review comments.
> Please find my response inline.
> 
> > -----Original Message-----
> > From: Greg KH <gregkh@linuxfoundation.org>
> > Sent: Tuesday, January 31, 2023 5:13 PM
> > To: Manne, Nava kishore <nava.kishore.manne@amd.com>
> > Cc: michal.simek@xilinx.com; mdf@kernel.org; hao.wu@intel.com;
> > yilun.xu@intel.com; trix@redhat.com; ronak.jain@xilinx.com;
> > tanmay.shah@xilinx.com; Levinsky, Ben <ben.levinsky@amd.com>;
> > rajan.vaja@xilinx.com; harsha.harsha@xilinx.com;
> > mathieu.poirier@linaro.org; lakshmi.sai.krishna.potthuri@xilinx.com;
> > arnd@arndb.de; linux-arm-kernel@lists.infradead.org; linux-
> > kernel@vger.kernel.org; linux-fpga@vger.kernel.org
> > Subject: Re: [PATCH v5 2/2] fpga: zynqmp-fpga: Adds status interface
> > 
> > On Tue, Jan 31, 2023 at 03:18:10PM +0530, Nava kishore Manne wrote:
> > > Adds status interface for zynqmp-fpga, It's a read only interface
> > > which allows the user to get the Programmable Logic(PL) configuration
> > > status.
> > >
> > > Usage:
> > > To read the Programmable Logic(PL) configuration status
> > >         cat /sys/class/fpga_manager/<fpga>/device/status
> > >
> > > Signed-off-by: Nava kishore Manne <nava.kishore.manne@amd.com>
> > > ---
> > > Changes for v2:
> > >               - Updated status messages handling logic as suggested by Xu Yilun.
> > >
> > > Changes for v3:
> > >               - Updated status interface handling logic (Restrict the status
> > >                 interface to the device-specific instead of handled by the core)
> > >                 as suggested by Xu Yilun.
> > >
> > > Changes for v4:
> > >               - Limit the error strings to one word for each as suggested by
> > >                 Xu Yilun
> > >
> > > Changes for v5:
> > >               - Added new sysfs-driver-zynqmp-fpga file.
> > >
> > >  .../ABI/testing/sysfs-driver-zynqmp-fpga      | 18 ++++
> > >  drivers/fpga/zynqmp-fpga.c                    | 87 +++++++++++++++++++
> > >  2 files changed, 105 insertions(+)
> > >  create mode 100644 Documentation/ABI/testing/sysfs-driver-zynqmp-fpga
> > >
> > > diff --git a/Documentation/ABI/testing/sysfs-driver-zynqmp-fpga
> > > b/Documentation/ABI/testing/sysfs-driver-zynqmp-fpga
> > > new file mode 100644
> > > index 000000000000..66c98bb8dfba
> > > --- /dev/null
> > > +++ b/Documentation/ABI/testing/sysfs-driver-zynqmp-fpga
> > > @@ -0,0 +1,18 @@
> > > +What:		/sys/class/fpga_manager/<fpga>/device/status
> > > +Date:		Jan 2023
> > > +KernelVersion:	6.2
> > > +Contact:	Nava kishore Manne <nava.kishore.manne@amd.com>
> > > +Description:	Read fpga status as a string.
> > > +		If FPGA programming operation fails, it could be caused by
> > crc
> > > +		error or incompatible bitstream image. The intent of this
> > > +		interface is to provide more detailed information for FPGA
> > > +		programming errors to userspace. This is a list of strings for
> > > +		the supported status.
> > > +
> > > +		* CRC-Error		- CRC error detected by hardware.
> > > +		* Security-Error	- Security error detected by hardware.
> > > +		* Initialization-Error	- Device Initialization error.
> > > +		* Internal-Signal-Error	- Device internal signal error.
> > > +		* I/Os-High-Z-state	- All I/Os are placed in High-Z state.
> > > +		* Sequence-Error	- Device start-up sequence error.
> > > +		* Firmware-Error	- Firmware error.
> > > diff --git a/drivers/fpga/zynqmp-fpga.c b/drivers/fpga/zynqmp-fpga.c
> > > index c60f20949c47..81d3e18527ee 100644
> > > --- a/drivers/fpga/zynqmp-fpga.c
> > > +++ b/drivers/fpga/zynqmp-fpga.c
> > > @@ -15,6 +15,37 @@
> > >  /* Constant Definitions */
> > >  #define IXR_FPGA_DONE_MASK	BIT(3)
> > >
> > > +/* Error Register */
> > > +#define IXR_FPGA_ERR_CRC_ERR		BIT(0)
> > > +#define IXR_FPGA_ERR_SECURITY_ERR	BIT(16)
> > > +
> > > +/* Signal Status Register */
> > > +#define IXR_FPGA_END_OF_STARTUP		BIT(4)
> > > +#define IXR_FPGA_GST_CFG_B		BIT(5)
> > > +#define IXR_FPGA_INIT_B_INTERNAL	BIT(11)
> > > +#define IXR_FPGA_DONE_INTERNAL_SIGNAL	BIT(13)
> > > +
> > > +/* FPGA error status. */
> > > +enum {
> > > +	ZYNQMP_FPGA_STATUS_CRC_ERR,
> > > +	ZYNQMP_FPGA_STATUS_SECURITY_ERR,
> > > +	ZYNQMP_FPGA_STATUS_DEVICE_INIT_ERR,
> > > +	ZYNQMP_FPGA_STATUS_SIGNAL_ERR,
> > > +	ZYNQMP_FPGA_STATUS_HIGH_Z_STATE_ERR,
> > > +	ZYNQMP_FPGA_STATUS_EOS_ERR,
> > > +	ZYNQMP_FPGA_MGR_STATUS_FIRMWARE_REQ_ERR,
> > > +};
> > > +
> > > +static const char * const zynqmp_fpga_error_statuses[] = {
> > > +	[ZYNQMP_FPGA_STATUS_CRC_ERR] = "CRC-Error",
> > > +	[ZYNQMP_FPGA_STATUS_SECURITY_ERR] = "Security-Error",
> > > +	[ZYNQMP_FPGA_STATUS_DEVICE_INIT_ERR] = "Initialization-Error",
> > > +	[ZYNQMP_FPGA_STATUS_SIGNAL_ERR] = "Internal-Signal-Error",
> > > +	[ZYNQMP_FPGA_STATUS_HIGH_Z_STATE_ERR] = "I/Os-High-Z-state",
> > > +	[ZYNQMP_FPGA_STATUS_EOS_ERR] = "Sequence-Error",
> > > +	[ZYNQMP_FPGA_MGR_STATUS_FIRMWARE_REQ_ERR] = "Firmware-
> > Error", };
> > > +
> > >  /**
> > >   * struct zynqmp_fpga_priv - Private data structure
> > >   * @dev:	Device data structure
> > > @@ -77,6 +108,54 @@ static enum fpga_mgr_states
> > zynqmp_fpga_ops_state(struct fpga_manager *mgr)
> > >  	return FPGA_MGR_STATE_UNKNOWN;
> > >  }
> > >
> > > +static ssize_t status_show(struct device *dev,
> > > +			   struct device_attribute *attr, char *buf) {
> > > +	unsigned long status = 0;
> > > +	ssize_t len = 0;
> > > +	u32 reg_val;
> > > +	int ret;
> > > +	u8 i;
> > > +
> > > +	ret = zynqmp_pm_fpga_get_config_status(&reg_val);
> > > +	if (!ret) {
> > > +		if (reg_val & IXR_FPGA_ERR_CRC_ERR)
> > > +			status |= ZYNQMP_FPGA_STATUS_CRC_ERR;
> > > +		if (reg_val & IXR_FPGA_ERR_SECURITY_ERR)
> > > +			status |= ZYNQMP_FPGA_STATUS_SECURITY_ERR;
> > > +		if (!(reg_val & IXR_FPGA_INIT_B_INTERNAL))
> > > +			status |= ZYNQMP_FPGA_STATUS_DEVICE_INIT_ERR;
> > > +		if (!(reg_val & IXR_FPGA_DONE_INTERNAL_SIGNAL))
> > > +			status |= ZYNQMP_FPGA_STATUS_SIGNAL_ERR;
> > > +		if (!(reg_val & IXR_FPGA_GST_CFG_B))
> > > +			status |=
> > ZYNQMP_FPGA_STATUS_HIGH_Z_STATE_ERR;
> > > +		if (!(reg_val & IXR_FPGA_END_OF_STARTUP))
> > > +			status |= ZYNQMP_FPGA_STATUS_EOS_ERR;
> > > +	} else {
> > > +		status =
> > ZYNQMP_FPGA_MGR_STATUS_FIRMWARE_REQ_ERR;
> > > +	}
> > > +
> > > +	for_each_set_bit(i, &status,
> > ARRAY_SIZE(zynqmp_fpga_error_statuses))
> > > +		len += sysfs_emit_at(buf, len, "%s ",
> > > +				     zynqmp_fpga_error_statuses[i]);
> > > +
> > 
> > Sorry, but no, you can not export a list of strings that userspace is somehow
> > going to parse.
> > 
> > As this is all a bit field, why not just export the raw hex value instead and let
> > userspace parse what bits are set?
> > 
> 
> This implementation is align with the fpga core status interface(https://git.kernel.org/pub/scm/linux/kernel/git/fpga/linux-fpga.git/tree/drivers/fpga/fpga-mgr.c?h=for-6.2#n632)
> I Agree to export the raw hex value instead of multiple error strings.

I also agree, it is a much simpler implementation.

> In case of exporting the raw hex value for status can we update this fpga-mgr.c core file (status_show() API) 
> instead of creating individual sysfs file per driver/device? and with this proposed implementation

But I don't think we should change format of the existing 'status' sysfs node,
it impacts the existing users. Just freeze it and add no new user.

> will also fix the issues/Limitations with generic status interface.
> 
> Existing limitation with the generic fpga status interface: 
> Different vendors have different error sets defined by Hardware. If we always define the new bits when we cannot find an exact 1:1
> mapping in the core the 64 bits would soon be used out.

Even if we change the status interface to raw hex output, issues are still there.
I guess you may want to output bits specifically defined by each driver, but then
it makes no sense to have this generic class interface. Users can't tell
what the status is by just reading the interface.

So as I mentioned before, my preference is driver creates its own sysfs
interface for its own hardware status if needed.

Thanks,
Yilun 

> 
> Xu Yilun: Can you please share your thoughts here?  
> 
> Regards,
> Navakishore.
