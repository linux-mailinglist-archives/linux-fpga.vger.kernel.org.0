Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 188AC6A27DB
	for <lists+linux-fpga@lfdr.de>; Sat, 25 Feb 2023 09:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjBYILH (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 25 Feb 2023 03:11:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjBYILG (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sat, 25 Feb 2023 03:11:06 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC3E231E1;
        Sat, 25 Feb 2023 00:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677312664; x=1708848664;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zl1soPlKWhxXi+aD3Tc6A2vPkfiirIkVGjCgZGRribQ=;
  b=lBwoTxWCB5BpYLVI67whMb9SVzLCuBScO4jFkSQGEjWoqjYnAJX8BBs3
   gTBzm/7dXlegH1ctrXDfDTKx81oHG2fFHP+4RfLK1r18Uq35MnqM1nM/U
   6Io0/u53r2rJG0Jt3PA/Qts5oFM8PAlnhdcggLpL71SRWByQKRKNPWr5E
   DExMJbK8xXLtaD49u2pYlGm0DqSS8BUoGAXmL3y77dOCeQGqrEbHrQbdJ
   xm4tC/hvt/A/cOABl0BCTKPKlomOeYWHbOyVg3iyVeXj4IvcVf6L+gTRI
   0Kj+HkWZtBJDiWJPVjwSy78hpH2FrPutKucVqZ3KVJ61/iLnEe0OroZ+B
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10631"; a="314033376"
X-IronPort-AV: E=Sophos;i="5.97,327,1669104000"; 
   d="scan'208";a="314033376"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2023 00:11:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10631"; a="703433428"
X-IronPort-AV: E=Sophos;i="5.97,327,1669104000"; 
   d="scan'208";a="703433428"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga008.jf.intel.com with ESMTP; 25 Feb 2023 00:11:00 -0800
Date:   Sat, 25 Feb 2023 15:59:59 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Nava kishore Manne <nava.kishore.manne@amd.com>
Cc:     michal.simek@xilinx.com, mdf@kernel.org, hao.wu@intel.com,
        trix@redhat.com, ronak.jain@xilinx.com, gregkh@linuxfoundation.org,
        tanmay.shah@xilinx.com, mathieu.poirier@linaro.org,
        ben.levinsky@amd.com, rajan.vaja@xilinx.com,
        harsha.harsha@xilinx.com, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: Re: [PATCH v7 2/2] fpga: zynqmp-fpga: Adds status interface
Message-ID: <Y/m//5tKMqD7ZeLo@yilunxu-OptiPlex-7050>
References: <20230224120738.329416-1-nava.kishore.manne@amd.com>
 <20230224120738.329416-3-nava.kishore.manne@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230224120738.329416-3-nava.kishore.manne@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2023-02-24 at 17:37:38 +0530, Nava kishore Manne wrote:
> Adds status interface for zynqmp-fpga. It's a read only interface
> which allows the user to get the Programmable Logic(PL) configuration
> status.
> 
> Usage:
> To read the Programmable Logic(PL) configuration status.
> cat /sys/bus/platform/drivers/zynqmp_fpga_manager/firmware:zynqmp-firmware:pcap/status
> 
> Signed-off-by: Nava kishore Manne <nava.kishore.manne@amd.com>

Acked-by: Xu Yilun <yilun.xu@intel.com>

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
> Changes for v6:
>               - Updated the sysfs interface to cat /sys/bus/platform/drivers/...
>                 as suggested by Xu Yilun.
>               - Exported raw hex value instead of multiple error strings
>                 as suggested by Greg.
> 
> Changes for v7:
>               - Fixed some minor issues as suggested by Xu Yilun.
> 
>  .../ABI/testing/sysfs-driver-zynqmp-fpga      | 73 +++++++++++++++++++
>  drivers/fpga/zynqmp-fpga.c                    | 21 ++++++
>  2 files changed, 94 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-driver-zynqmp-fpga
> 
> diff --git a/Documentation/ABI/testing/sysfs-driver-zynqmp-fpga b/Documentation/ABI/testing/sysfs-driver-zynqmp-fpga
> new file mode 100644
> index 000000000000..8f93d27b6d91
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-driver-zynqmp-fpga
> @@ -0,0 +1,73 @@
> +What:		/sys/bus/platform/drivers/zynqmp_fpga_manager/firmware:zynqmp-firmware:pcap/status
> +Date:		February 2023
> +KernelVersion:	6.4
> +Contact:	Nava kishore Manne <nava.kishore.manne@amd.com>
> +Description:	(RO) Read fpga status.
> +		Read returns a hexadecimal value that tells the current status
> +		of the FPGA device. Each bit position in the status value is
> +		described Below(see ug570 chapter 9).
> +		https://docs.xilinx.com/v/u/en-US/ug570-ultrascale-configuration
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
> index c60f20949c47..f3434e2c487b 100644
> --- a/drivers/fpga/zynqmp-fpga.c
> +++ b/drivers/fpga/zynqmp-fpga.c
> @@ -77,6 +77,26 @@ static enum fpga_mgr_states zynqmp_fpga_ops_state(struct fpga_manager *mgr)
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
> +	return sysfs_emit(buf, "0x%x\n", status);
> +}
> +static DEVICE_ATTR_RO(status);
> +
> +static struct attribute *zynqmp_fpga_attrs[] = {
> +	&dev_attr_status.attr,
> +	NULL,
> +};
> +ATTRIBUTE_GROUPS(zynqmp_fpga);
> +
>  static const struct fpga_manager_ops zynqmp_fpga_ops = {
>  	.state = zynqmp_fpga_ops_state,
>  	.write_init = zynqmp_fpga_ops_write_init,
> @@ -113,6 +133,7 @@ static struct platform_driver zynqmp_fpga_driver = {
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
