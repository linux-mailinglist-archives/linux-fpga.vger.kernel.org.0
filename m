Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A58F682BB6
	for <lists+linux-fpga@lfdr.de>; Tue, 31 Jan 2023 12:44:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231844AbjAaLmv (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 31 Jan 2023 06:42:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231802AbjAaLmm (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 31 Jan 2023 06:42:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20AD623C5D;
        Tue, 31 Jan 2023 03:42:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B14B0614BB;
        Tue, 31 Jan 2023 11:42:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F1B9C4339B;
        Tue, 31 Jan 2023 11:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675165360;
        bh=XRAFPWWquRK1zwy2lCEBziv6ZCdmEycsChN+P9F6L/o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AP1knRte0q45IitAGytRys/kY3zh85gG2XP9DdJoDqKVhieC9baaonkO4bLqOGkQ7
         FC1SESOucfwy0i10b92mSaWmSBqoH3Y8RhMNVdCQaD/ySwq3DWpnZaLtAGx8J6sTIf
         HRB3/kkDxjspbl8fpWi5YPgADtZycmu7P2rnlvQE=
Date:   Tue, 31 Jan 2023 12:42:37 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nava kishore Manne <nava.kishore.manne@amd.com>
Cc:     michal.simek@xilinx.com, mdf@kernel.org, hao.wu@intel.com,
        yilun.xu@intel.com, trix@redhat.com, ronak.jain@xilinx.com,
        tanmay.shah@xilinx.com, ben.levinsky@amd.com,
        rajan.vaja@xilinx.com, harsha.harsha@xilinx.com,
        mathieu.poirier@linaro.org,
        lakshmi.sai.krishna.potthuri@xilinx.com, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: Re: [PATCH v5 2/2] fpga: zynqmp-fpga: Adds status interface
Message-ID: <Y9j+rZQkiPcIPxOr@kroah.com>
References: <20230131094810.1945541-1-nava.kishore.manne@amd.com>
 <20230131094810.1945541-3-nava.kishore.manne@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230131094810.1945541-3-nava.kishore.manne@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Jan 31, 2023 at 03:18:10PM +0530, Nava kishore Manne wrote:
> Adds status interface for zynqmp-fpga, It's a read only interface
> which allows the user to get the Programmable Logic(PL) configuration
> status.
> 
> Usage:
> To read the Programmable Logic(PL) configuration status
>         cat /sys/class/fpga_manager/<fpga>/device/status
> 
> Signed-off-by: Nava kishore Manne <nava.kishore.manne@amd.com>
> ---
> Changes for v2:
>               - Updated status messages handling logic as suggested by Xu Yilun.
> 
> Changes for v3:
>               - Updated status interface handling logic (Restrict the status
>                 interface to the device-specific instead of handled by the core)
>                 as suggested by Xu Yilun.
> 
> Changes for v4:
>               - Limit the error strings to one word for each as suggested by
>                 Xu Yilun
> 
> Changes for v5:
>               - Added new sysfs-driver-zynqmp-fpga file.
> 
>  .../ABI/testing/sysfs-driver-zynqmp-fpga      | 18 ++++
>  drivers/fpga/zynqmp-fpga.c                    | 87 +++++++++++++++++++
>  2 files changed, 105 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-driver-zynqmp-fpga
> 
> diff --git a/Documentation/ABI/testing/sysfs-driver-zynqmp-fpga b/Documentation/ABI/testing/sysfs-driver-zynqmp-fpga
> new file mode 100644
> index 000000000000..66c98bb8dfba
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-driver-zynqmp-fpga
> @@ -0,0 +1,18 @@
> +What:		/sys/class/fpga_manager/<fpga>/device/status
> +Date:		Jan 2023
> +KernelVersion:	6.2
> +Contact:	Nava kishore Manne <nava.kishore.manne@amd.com>
> +Description:	Read fpga status as a string.
> +		If FPGA programming operation fails, it could be caused by crc
> +		error or incompatible bitstream image. The intent of this
> +		interface is to provide more detailed information for FPGA
> +		programming errors to userspace. This is a list of strings for
> +		the supported status.
> +
> +		* CRC-Error		- CRC error detected by hardware.
> +		* Security-Error	- Security error detected by hardware.
> +		* Initialization-Error	- Device Initialization error.
> +		* Internal-Signal-Error	- Device internal signal error.
> +		* I/Os-High-Z-state	- All I/Os are placed in High-Z state.
> +		* Sequence-Error	- Device start-up sequence error.
> +		* Firmware-Error	- Firmware error.
> diff --git a/drivers/fpga/zynqmp-fpga.c b/drivers/fpga/zynqmp-fpga.c
> index c60f20949c47..81d3e18527ee 100644
> --- a/drivers/fpga/zynqmp-fpga.c
> +++ b/drivers/fpga/zynqmp-fpga.c
> @@ -15,6 +15,37 @@
>  /* Constant Definitions */
>  #define IXR_FPGA_DONE_MASK	BIT(3)
>  
> +/* Error Register */
> +#define IXR_FPGA_ERR_CRC_ERR		BIT(0)
> +#define IXR_FPGA_ERR_SECURITY_ERR	BIT(16)
> +
> +/* Signal Status Register */
> +#define IXR_FPGA_END_OF_STARTUP		BIT(4)
> +#define IXR_FPGA_GST_CFG_B		BIT(5)
> +#define IXR_FPGA_INIT_B_INTERNAL	BIT(11)
> +#define IXR_FPGA_DONE_INTERNAL_SIGNAL	BIT(13)
> +
> +/* FPGA error status. */
> +enum {
> +	ZYNQMP_FPGA_STATUS_CRC_ERR,
> +	ZYNQMP_FPGA_STATUS_SECURITY_ERR,
> +	ZYNQMP_FPGA_STATUS_DEVICE_INIT_ERR,
> +	ZYNQMP_FPGA_STATUS_SIGNAL_ERR,
> +	ZYNQMP_FPGA_STATUS_HIGH_Z_STATE_ERR,
> +	ZYNQMP_FPGA_STATUS_EOS_ERR,
> +	ZYNQMP_FPGA_MGR_STATUS_FIRMWARE_REQ_ERR,
> +};
> +
> +static const char * const zynqmp_fpga_error_statuses[] = {
> +	[ZYNQMP_FPGA_STATUS_CRC_ERR] = "CRC-Error",
> +	[ZYNQMP_FPGA_STATUS_SECURITY_ERR] = "Security-Error",
> +	[ZYNQMP_FPGA_STATUS_DEVICE_INIT_ERR] = "Initialization-Error",
> +	[ZYNQMP_FPGA_STATUS_SIGNAL_ERR] = "Internal-Signal-Error",
> +	[ZYNQMP_FPGA_STATUS_HIGH_Z_STATE_ERR] = "I/Os-High-Z-state",
> +	[ZYNQMP_FPGA_STATUS_EOS_ERR] = "Sequence-Error",
> +	[ZYNQMP_FPGA_MGR_STATUS_FIRMWARE_REQ_ERR] = "Firmware-Error",
> +};
> +
>  /**
>   * struct zynqmp_fpga_priv - Private data structure
>   * @dev:	Device data structure
> @@ -77,6 +108,54 @@ static enum fpga_mgr_states zynqmp_fpga_ops_state(struct fpga_manager *mgr)
>  	return FPGA_MGR_STATE_UNKNOWN;
>  }
>  
> +static ssize_t status_show(struct device *dev,
> +			   struct device_attribute *attr, char *buf)
> +{
> +	unsigned long status = 0;
> +	ssize_t len = 0;
> +	u32 reg_val;
> +	int ret;
> +	u8 i;
> +
> +	ret = zynqmp_pm_fpga_get_config_status(&reg_val);
> +	if (!ret) {
> +		if (reg_val & IXR_FPGA_ERR_CRC_ERR)
> +			status |= ZYNQMP_FPGA_STATUS_CRC_ERR;
> +		if (reg_val & IXR_FPGA_ERR_SECURITY_ERR)
> +			status |= ZYNQMP_FPGA_STATUS_SECURITY_ERR;
> +		if (!(reg_val & IXR_FPGA_INIT_B_INTERNAL))
> +			status |= ZYNQMP_FPGA_STATUS_DEVICE_INIT_ERR;
> +		if (!(reg_val & IXR_FPGA_DONE_INTERNAL_SIGNAL))
> +			status |= ZYNQMP_FPGA_STATUS_SIGNAL_ERR;
> +		if (!(reg_val & IXR_FPGA_GST_CFG_B))
> +			status |= ZYNQMP_FPGA_STATUS_HIGH_Z_STATE_ERR;
> +		if (!(reg_val & IXR_FPGA_END_OF_STARTUP))
> +			status |= ZYNQMP_FPGA_STATUS_EOS_ERR;
> +	} else {
> +		status = ZYNQMP_FPGA_MGR_STATUS_FIRMWARE_REQ_ERR;
> +	}
> +
> +	for_each_set_bit(i, &status, ARRAY_SIZE(zynqmp_fpga_error_statuses))
> +		len += sysfs_emit_at(buf, len, "%s ",
> +				     zynqmp_fpga_error_statuses[i]);
> +

Sorry, but no, you can not export a list of strings that userspace is
somehow going to parse.

As this is all a bit field, why not just export the raw hex value
instead and let userspace parse what bits are set?

thanks,

greg k-h
