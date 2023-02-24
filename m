Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB4656A162C
	for <lists+linux-fpga@lfdr.de>; Fri, 24 Feb 2023 06:15:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbjBXFOD (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 24 Feb 2023 00:14:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjBXFOC (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 24 Feb 2023 00:14:02 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F4D26CC3;
        Thu, 23 Feb 2023 21:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677215641; x=1708751641;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rafueas/Vcfut9/LWCGFPB0Qut6KMM0NFlHvmexhzNQ=;
  b=gbh9Wc5dy0Mp4SSdEsScFUmYasx6r98aesk+Rj7Kxqwv7ESVivJWNwQn
   9BLFpndI1i8EA++sWUjh1whkFbaG1v+SVPXhCn/up1yjs/dde6HOkIwSz
   CJM/C6A8uJhffUHfB+oo2Sgdq9m3cNBHLY+ge3w8W4+rvEQ8t6HwGcyXv
   TB8yjf0tF6rtnRsCUzyyU1X8cPJ8YjxNcX/zm6eROsgyQoGEB/2w0c13h
   3SGt07k2SWrVO67KwUwxJlmYYcTkOr305sJ095lNNSxJV1l/POCSInHXU
   qfythkNNv+eldXDKKatvfQaNi67YHcGLgyUL0LvjfxeTFyAOVy0FGL2st
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10630"; a="334819208"
X-IronPort-AV: E=Sophos;i="5.97,322,1669104000"; 
   d="scan'208";a="334819208"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2023 21:13:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10630"; a="918304007"
X-IronPort-AV: E=Sophos;i="5.97,322,1669104000"; 
   d="scan'208";a="918304007"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga006.fm.intel.com with ESMTP; 23 Feb 2023 21:13:49 -0800
Date:   Fri, 24 Feb 2023 13:02:49 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Nava kishore Manne <nava.kishore.manne@amd.com>
Cc:     michal.simek@xilinx.com, mdf@kernel.org, hao.wu@intel.com,
        trix@redhat.com, ronak.jain@xilinx.com, gregkh@linuxfoundation.org,
        tanmay.shah@xilinx.com, mathieu.poirier@linaro.org,
        ben.levinsky@amd.com, rajan.vaja@xilinx.com,
        harsha.harsha@xilinx.com, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: Re: [PATCH v6 2/2] fpga: zynqmp-fpga: Adds status interface
Message-ID: <Y/hE+dqK0OzuExJ0@yilunxu-OptiPlex-7050>
References: <20230217115036.2617396-1-nava.kishore.manne@amd.com>
 <20230217115036.2617396-3-nava.kishore.manne@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230217115036.2617396-3-nava.kishore.manne@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2023-02-17 at 17:20:36 +0530, Nava kishore Manne wrote:
> Adds status interface for zynqmp-fpga, It's a read only interface

s/,/.

> which allows the user to get the Programmable Logic(PL) configuration
> status.
> 
> Usage:
> To read the Programmable Logic(PL) configuration status
> 	cat /sys/bus/platform/drivers/zynqmp_fpga_manager/
> firmware:zynqmp-firmware:pcap/status

Don't wrap here.

> 
> Signed-off-by: Nava kishore Manne <nava.kishore.manne@amd.com>
> ---
> hanges for v2:
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
> Changes for v6:
>               - Updated the sysfs interface to cat /sys/bus/platform/drivers/...
> 		as suggested by Xu Yilun.
>               - Exported raw hex value instead of multiple error strings
>                 as suggested by Greg.
> 
>  .../ABI/testing/sysfs-driver-zynqmp-fpga      | 72 +++++++++++++++++++
>  drivers/fpga/zynqmp-fpga.c                    | 23 ++++++
>  2 files changed, 95 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-driver-zynqmp-fpga
> 
> diff --git a/Documentation/ABI/testing/sysfs-driver-zynqmp-fpga b/Documentation/ABI/testing/sysfs-driver-zynqmp-fpga
> new file mode 100644
> index 000000000000..af5d42916dd1
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-driver-zynqmp-fpga
> @@ -0,0 +1,72 @@
> +What:		/sys/bus/platform/drivers/zynqmp_fpga_manager/firmware:zynqmp-firmware:pcap/status
> +Date:		Jan 2023
> +KernelVersion:	6.2

Please update the version & Data, I expect this could be merged in next
cycle, so 6.4

> +Contact:	Nava kishore Manne <nava.kishore.manne@amd.com>
> +Description:	(RO) Read fpga status.
> +		Read returns a hexadecimal value that tells the current status
> +                of the FPGA device. Each bit position in the status value is
> +                described Below(see ug570 chapter 9).

Please provide the URL for ug570, the commit message in Patch #0 that
contains the info will not appear in mainline.

> +
> +		======================  ==============================================
> +		BIT(0)			0: No CRC error
> +					1: CRC error
> +
> +		BIT(1)			0: Decryptor security not set
> +					1: Decryptor security set
> +
> +		BIT(2)			0: MMCMs/PLLs are not locked
> +					1: MMCMs/PLLs are locked
> +
> +		BIT(3)			0: DCI not matched
> +					1: DCI matched
> +
> +		BIT(4)			0: Start-up sequence has not finished
> +					1: Start-up sequence has finished
> +
> +		BIT(5)			0: All I/Os are placed in High-Z state
> +					1: All I/Os behave as configured
> +
> +		BIT(6)			0: Flip-flops and block RAM are write disabled
> +					1: Flip-flops and block RAM are write enabled
> +
> +		BIT(7)			0: GHIGH_B_STATUS asserted
> +					1: GHIGH_B_STATUS deasserted
> +
> +		BIT(8) to BIT(10)	Status of the mode pins
> +
> +		BIT(11)			0: Initialization has not finished
> +					1: Initialization finished
> +
> +		BIT(12)			Value on INIT_B_PIN pin
> +
> +		BIT(13)			0: Signal not released
> +					1: Signal released
> +
> +		BIT(14)			Value on DONE_PIN pin.
> +
> +		BIT(15)			0: No IDCODE_ERROR
> +					1: IDCODE_ERROR
> +
> +		BIT(16)			0: No SECURITY_ERROR
> +					1: SECURITY_ERROR
> +
> +		BIT(17)			System Monitor over-temperature if set
> +
> +		BIT(18) to BIT(20)	Start-up state machine (0 to 7)
> +					Phase 0 = 000
> +					Phase 1 = 001
> +					Phase 2 = 011
> +					Phase 3 = 010
> +					Phase 4 = 110
> +					Phase 5 = 111
> +					Phase 6 = 101
> +					Phase 7 = 100
> +
> +		BIT(25) to BIT(26)	Indicates the detected bus width
> +					00 = x1
> +					01 = x8
> +					10 = x16
> +					11 = x32
> +		======================  ==============================================
> +
> +		The other bits are reserved.
> diff --git a/drivers/fpga/zynqmp-fpga.c b/drivers/fpga/zynqmp-fpga.c
> index c60f20949c47..0c58ca27319f 100644
> --- a/drivers/fpga/zynqmp-fpga.c
> +++ b/drivers/fpga/zynqmp-fpga.c
> @@ -77,6 +77,28 @@ static enum fpga_mgr_states zynqmp_fpga_ops_state(struct fpga_manager *mgr)
>  	return FPGA_MGR_STATE_UNKNOWN;
>  }
>  
> +static ssize_t status_show(struct device *dev,
> +			   struct device_attribute *attr, char *buf)
> +{
> +	u32 status;
> +	int ret;
> +
> +	ret = zynqmp_pm_fpga_get_config_status(&status);
> +	if (ret)
> +		return ret;
> +
> +	return sprintf(buf, "0x%x\n", status);

sysfs_emit?

> +}
> +

No blank line please.

> +static DEVICE_ATTR_RO(status);
> +
> +static struct attribute *zynqmp_fpga_attrs[] = {
> +	&dev_attr_status.attr,
> +	NULL,
> +};
> +

Same.

Thanks,
Yilun

> +ATTRIBUTE_GROUPS(zynqmp_fpga);
> +
>  static const struct fpga_manager_ops zynqmp_fpga_ops = {
>  	.state = zynqmp_fpga_ops_state,
>  	.write_init = zynqmp_fpga_ops_write_init,
> @@ -113,6 +135,7 @@ static struct platform_driver zynqmp_fpga_driver = {
>  	.driver = {
>  		.name = "zynqmp_fpga_manager",
>  		.of_match_table = of_match_ptr(zynqmp_fpga_of_match),
> +		.dev_groups = zynqmp_fpga_groups,
>  	},
>  };
>  
> -- 
> 2.25.1
> 
