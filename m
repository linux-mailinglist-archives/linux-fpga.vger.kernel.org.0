Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2949663388C
	for <lists+linux-fpga@lfdr.de>; Tue, 22 Nov 2022 10:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232607AbiKVJbR (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 22 Nov 2022 04:31:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232506AbiKVJbQ (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 22 Nov 2022 04:31:16 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D333F1CB39
        for <linux-fpga@vger.kernel.org>; Tue, 22 Nov 2022 01:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1669109471; x=1700645471;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/qQAYvEgVF63UmcnW0hjrnTOtcodjexdS0yGahH79ZA=;
  b=nESccZDv4oEOBbxH3I99Xq83oOz/rqC+ZQ/+4M/RQ6/RSCEHMItEbr+Q
   7/bdnhGjDzB9UXrrgUP9as6jgQytK1d8TTTber134A7tvos7BFcyLXDqA
   LKGwGHyOIVQLSOfktVsEhO1Bodt5EWTf35psQa/ldV0J6dJlMrhSodyRZ
   MhRu4JaZZTFX+K3kcsmtMAZhZsgLCvVR852oeBeh1IsfSknaVoxxnWUC1
   PeZTxx0WptIiRBBH1bbZgrq8mstSaUcnT77Oc8s+3E6ZQ26V2lG2PQ+RJ
   4RjbFpMyaXvmgFgVxbo7sp+HVnUTmoyWYjUJRegNDB0NiQOp0HgFTOeQQ
   w==;
X-IronPort-AV: E=Sophos;i="5.96,183,1665471600"; 
   d="scan'208";a="124561251"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Nov 2022 02:31:10 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 22 Nov 2022 02:31:09 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Tue, 22 Nov 2022 02:31:08 -0700
Date:   Tue, 22 Nov 2022 09:30:50 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Xu Yilun <yilun.xu@intel.com>
CC:     Conor Dooley <conor@kernel.org>, <linux-fpga@vger.kernel.org>,
        Cyril Jean <cyril.jean@microchip.com>,
        Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>,
        <linux-riscv@lists.infradead.org>
Subject: Re: [RFC] fpga: add PolarFire SoC IAP support
Message-ID: <Y3yWyn2UQjECZ4kJ@wendy>
References: <20221121225748.124900-1-conor@kernel.org>
 <Y3w/zFCcP+CXGCqS@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y3w/zFCcP+CXGCqS@yilunxu-OptiPlex-7050>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,T_SPF_TEMPERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Nov 22, 2022 at 11:19:40AM +0800, Xu Yilun wrote:
> On 2022-11-21 at 22:57:49 +0000, Conor Dooley wrote:
> > From: Conor Dooley <conor.dooley@microchip.com>
> > 
> > Add support for "IAP" reprogramming of the FPGA fabric on PolarFire SoC.
> > 
> > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> > ---
> > 
> > Hey all,
> > RFC yadda yadda, but not asking people to look at the code per se -
> > really what I am sending this RFC to achieve is a bit of feedback on
> > what the re-programming "flow" looks like.
> > 
> > PolarFire and the SoC variants are flash FPGAs. All well and good for
> > PolarFire, but for PolarFire SoC in IAP mode it is re-programmed from
> > the on-board SoC. The spi-slave stuff that Ivan upstreamed recently
> > works too, but that's only when you have an external programmer.
> > 
> > IAP, or In Application Programming, a programming running on the cpu
> > cores writes the FPGA bitstream, or I suppose "firmware" in Linux land,
> > out to a flash chip which the system then will use to reprogram the
> > FPGA. When IAP is initiated, the system controller will take the FPGA
> > down completely & do the reprogramming. This means, once Linux (or some
> 
> Do you mean the Linux OS, FPGA mgr driver & reprograming Application are
> all running on the SoC?

Aye. What we have is 4 RISC-V cores running Linux & then the system
controller. The system controller is accessed via a mailbox, but is part
of the SoC. The fpga manager driver is, as you might imagine, running on
the RISC-V cores.
I suppose the "reprogramming Application" is part of the system
controller functionality & yea, runs on the SoC.

> > other program) kicks off the re-programming (in write_complete() below)
> > the system will *immediately* power cycle, whether the reprogramming
> > passes or not. You can see in my write_complete() implementation, that I
> > do not expect the function to return, unless we catch an error case early.
> 
> I don't think an FPGA driver could have an interface to power cycle the
> whole system.

Right. That was kinda my assumption too.

> > From my cursory looking around, there doesnt appear to me to be all that
> > much info in-tree about what each FPGA does when you reprogram it, but
> > it doesn't appear that for other FPGAs the CPUs get shut down during
> > this kind of self-reprogramming?
> > 
> > The alternative approach would be to use the "auto update" mode, which
> > just installs an image that will not be used until the FPGA is rebooted
> > in the regular way. Then, on reboot, the system controller would pluck
> 
> This seems to be a better way from OS perspective.

Again, yup. I just was not sure if there was an expectation that the
device would be reprogrammed once write_complete() terminated.

> > the image from its flash chip and program the FPGA with it. From the
> > last time I looked at the documentation (and the implementations) it
> > seemed that people had custom (and out of tree) ways to initiate/handle
> > the programming, so perhaps I have the freedom to do the "auto update"
> > approach, even if it may be a little different to other implementations?
> 
> FPGA manager framework takes care of the runtime FPGA reprograming, a
> main concern is the removal and re-enumeration of the sub devices when
> an FPGA region is being reprogramed. Otherwise, OS is not aware of the
> change of the devices and may just crash.

Right. I don't think I need to worry about this since initiating a
reprogramming from within Linux would take take the CPUs down too!

> For your "auto update" mode, I assume it doesn't affect the running
> devices at all, just do flash read/write. So maybe leverage MTD is just
> fine?

Aye, it would just write the image to the flash, set up the relevant
bits to make sure auto-update would trigger & validate the bitstream
written to the flash. Then nothing would happen until the user reboots
their system.

Thanks for your help,
Conor.

> > If I've missed something, please let me know. I hope I have!
> > 
> > I've only recently got a board capable of testing this & have not yet
> > tested my code here in anger etc, it's just the high level thoughts
> > about how to approach the re-programming in an FPGA manager friendly way
> > that I'm looking for comments on.
> > 
> > @LKP folks, if you happen to see this - you can disable building this
> > patch, it won't without some dependencies ;)
> > 
> > Thanks,
> > Conor.
> > ---
> >  drivers/fpga/Kconfig         |   6 +
> >  drivers/fpga/Makefile        |   1 +
> >  drivers/fpga/microchip-iap.c | 350 +++++++++++++++++++++++++++++++++++
> >  3 files changed, 357 insertions(+)
> >  create mode 100644 drivers/fpga/microchip-iap.c
> > 
> > diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> > index 6c416955da53..525d753a28a4 100644
> > --- a/drivers/fpga/Kconfig
> > +++ b/drivers/fpga/Kconfig
> > @@ -255,6 +255,12 @@ config FPGA_M10_BMC_SEC_UPDATE
> >  	  (BMC) and provides support for secure updates for the BMC image,
> >  	  the FPGA image, the Root Entry Hashes, etc.
> >  
> > +config FPGA_MGR_MICROCHIP_IAP
> > +	tristate "Microchip Polarfire IAP FPGA manager"
> > +	depends on POLARFIRE_SOC_SYS_CTRL
> > +	help
> > +	  NOP
> > +
> >  config FPGA_MGR_MICROCHIP_SPI
> >  	tristate "Microchip Polarfire SPI FPGA manager"
> >  	depends on SPI
> > diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
> > index 42ae8b58abce..df1dfb54046b 100644
> > --- a/drivers/fpga/Makefile
> > +++ b/drivers/fpga/Makefile
> > @@ -19,6 +19,7 @@ obj-$(CONFIG_FPGA_MGR_XILINX_SPI)	+= xilinx-spi.o
> >  obj-$(CONFIG_FPGA_MGR_ZYNQ_FPGA)	+= zynq-fpga.o
> >  obj-$(CONFIG_FPGA_MGR_ZYNQMP_FPGA)	+= zynqmp-fpga.o
> >  obj-$(CONFIG_FPGA_MGR_VERSAL_FPGA)	+= versal-fpga.o
> > +obj-$(CONFIG_FPGA_MGR_MICROCHIP_IAP)	+= microchip-iap.o
> >  obj-$(CONFIG_FPGA_MGR_MICROCHIP_SPI)	+= microchip-spi.o
> >  obj-$(CONFIG_ALTERA_PR_IP_CORE)		+= altera-pr-ip-core.o
> >  obj-$(CONFIG_ALTERA_PR_IP_CORE_PLAT)	+= altera-pr-ip-core-plat.o
> > diff --git a/drivers/fpga/microchip-iap.c b/drivers/fpga/microchip-iap.c
> > new file mode 100644
> > index 000000000000..10f25ec64d32
> > --- /dev/null
> > +++ b/drivers/fpga/microchip-iap.c
> > @@ -0,0 +1,350 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Microchip Polarfire SoC "IAP" FPGA reprogramming.
> > + *
> > + * Copyright (c) 2022 Microchip Corporation. All rights reserved.
> > + *
> > + * Author: Conor Dooley <conor.dooley@microchip.com>
> > + */
> > +#include <linux/module.h>
> > +#include <linux/mtd/mtd.h>
> > +#include <linux/of_device.h>
> > +#include <linux/fpga/fpga-mgr.h>
> > +#include <soc/microchip/mpfs.h>
> > +
> > +#define IAP_DEFAULT_MBOX_OFFSET		0u
> > +#define IAP_DEFAULT_RESP_OFFSET		0u
> > +
> > +#define IAP_FEATURE_CMD_OPCODE		0x05
> > +#define IAP_FEATURE_CMD_DATA_SIZE	0u
> > +#define IAP_FEATURE_RESP_SIZE		33u
> > +#define IAP_FEATURE_CMD_DATA		NULL
> > +#define IAP_FEATURE_ENABLED		BIT(5)
> > +
> > +#define IAP_VERIFY_CMD_OPCODE		0x22
> > +#define IAP_VERIFY_CMD_DATA_SIZE	0u
> > +#define IAP_VERIFY_RESP_SIZE		1u
> > +#define IAP_VERIFY_CMD_DATA		NULL
> > +
> > +#define IAP_PROGRAM_CMD_OPCODE		0x42
> > +#define IAP_PROGRAM_CMD_DATA_SIZE	0u
> > +#define IAP_PROGRAM_RESP_SIZE		1u
> > +#define IAP_PROGRAM_CMD_DATA		NULL
> > +
> > +#define IAP_DIRECTORY_WIDTH		4u
> > +#define IAP_UPGRADE_INDEX		1u
> > +#define IAP_UPGRADE_DIRECTORY		(IAP_UPGRADE_INDEX * 0x4)
> > +#define IAP_IMAGE_INDEX			2u
> > +#define IAP_IMAGE_DIRECTORY		(IAP_IMAGE_INDEX * 0x4)
> > +#define IAP_IMAGE_ADDRESS		(IAP_IMAGE_INDEX * 0xA00000)
> > +
> > +struct mpf_iap_config {
> > +	u8 feature_response_size;
> > +};
> > +
> > +struct mpf_iap_priv {
> > +	struct mpfs_sys_controller *sys_controller;
> > +	struct device *dev;
> > +	struct fpga_region *region;
> > +	struct mpf_iap_config *config;
> > +	struct mtd_info *flash;
> > +};
> > +
> > +static enum fpga_mgr_states mpf_iap_state(struct fpga_manager *mgr)
> > +{
> > +	struct mpf_iap_priv *priv = mgr->priv;
> > +	struct mpfs_mss_response *response;
> > +	struct mpfs_mss_msg *message;
> > +	u32 *response_msg;
> > +	int ret;
> > +	enum fpga_mgr_states rc = FPGA_MGR_STATE_WRITE_INIT_ERR;
> > +
> > +	response_msg = devm_kzalloc(priv->dev,
> > +				    IAP_FEATURE_RESP_SIZE * sizeof(response_msg),
> > +				    GFP_KERNEL);
> > +	if (!response_msg)
> > +		return FPGA_MGR_STATE_WRITE_INIT_ERR;
> > +
> > +	response = devm_kzalloc(priv->dev, sizeof(struct mpfs_mss_response), GFP_KERNEL);
> > +	if (!response) {
> > +		devm_kfree(priv->dev, response_msg);
> > +		return FPGA_MGR_STATE_WRITE_INIT_ERR;
> > +	}
> > +
> > +	message = devm_kzalloc(priv->dev, sizeof(struct mpfs_mss_msg), GFP_KERNEL);
> > +	if (!response) {
> > +		devm_kfree(priv->dev, response_msg);
> > +		devm_kfree(priv->dev, response);
> > +		return FPGA_MGR_STATE_WRITE_INIT_ERR;
> > +	}
> > +
> > +	/*
> > +	 * To verify that IAP is possible, the "Query Security Service Request"
> > +	 * is performed. Bit 5 of byte 1 is "UL_IAP" & if it is set, IAP is not
> > +	 * possible.
> > +	 * This service has no command data & does not overload mbox_offset.
> > +	 * The size of the response varies between PolarFire & PolarFire SoC.
> > +	 */
> > +	response->resp_msg = response_msg;
> > +	response->resp_size = IAP_FEATURE_RESP_SIZE;
> > +	message->cmd_opcode = IAP_FEATURE_CMD_OPCODE;
> > +	message->cmd_data_size = IAP_FEATURE_CMD_DATA_SIZE;
> > +	message->response = response;
> > +	message->cmd_data = IAP_FEATURE_CMD_DATA;
> > +	message->mbox_offset = IAP_DEFAULT_MBOX_OFFSET;
> > +	message->resp_offset = IAP_DEFAULT_RESP_OFFSET;
> > +
> > +	ret = mpfs_blocking_transaction(priv->sys_controller, message);
> > +	if (ret | response->resp_status) {
> > +		rc = FPGA_MGR_STATE_UNKNOWN;
> > +		goto out;
> > +	}
> > +
> > +	if (!(response_msg[1] & IAP_FEATURE_ENABLED))
> > +		rc = FPGA_MGR_STATE_OPERATING;
> > +
> > +out:
> > +	devm_kfree(priv->dev, response_msg);
> > +	devm_kfree(priv->dev, response);
> > +	devm_kfree(priv->dev, message);
> > +
> > +	return rc;
> > +}
> > +
> > +static int mpf_iap_write_init(struct fpga_manager *mgr, struct fpga_image_info *info,
> > +			      const char *buf, size_t count)
> > +{
> > +	struct mpf_iap_priv *priv = mgr->priv;
> > +	size_t *bytes_read;
> > +	u32 upgrade_address;
> > +
> > +	priv->flash = mpfs_sys_controller_get_flash(priv->sys_controller);
> > +	if (!priv->flash)
> > +		return PTR_ERR(priv->flash);
> > +
> > +	/*
> > +	 * We need to read the "SPI DIRECTORY" in the first 1 KiB, to see if
> > +	 * the index 1 has an address in it. If it is non zero, IAP will fail.
> > +	 * As the system controller will initiate upgrade mode instead.
> > +	 */
> > +	int ret = mtd_read(priv->flash, IAP_UPGRADE_DIRECTORY, IAP_DIRECTORY_WIDTH,
> > +			   bytes_read, (u_char *) &upgrade_address);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (*bytes_read != IAP_DIRECTORY_WIDTH || upgrade_address)
> > +		return -EIO;
> > +
> > +	return 0;
> > +}
> > +
> > +static int mpf_iap_write(struct fpga_manager *mgr, const char *buf, size_t count)
> > +{
> > +	/*
> > +	 * No parsing etc of the bitstream is required. The system controller
> > +	 * will do all of that itself - including verifying that the bitstream
> > +	 * is valid.
> > +	 */
> > +	struct mpf_iap_priv *priv = mgr->priv;
> > +	size_t *bytes_written;
> > +	u32 image_address = IAP_IMAGE_ADDRESS;
> > +
> > +	/*
> > +	 * We need to write the "SPI DIRECTORY" to the first 1 KiB, telling
> > +	 * the system controller where to find the actual bitstream.
> > +	 */
> > +	int ret = mtd_write(priv->flash, IAP_IMAGE_DIRECTORY, IAP_DIRECTORY_WIDTH,
> > +			    bytes_written, (u_char *) &image_address);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (*bytes_written != IAP_DIRECTORY_WIDTH)
> > +		return -EIO;
> > +
> > +	ret = mtd_write(priv->flash, (loff_t) image_address, count, bytes_written, (u_char *) buf);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (*bytes_written != count)
> > +		return -EIO;
> > +
> > +	return 0;
> > +}
> > +
> > +static int mpf_iap_write_complete(struct fpga_manager *mgr, struct fpga_image_info *info)
> > +{
> > +	struct mpf_iap_priv *priv = mgr->priv;
> > +	struct mpfs_mss_response *response;
> > +	struct mpfs_mss_msg *message;
> > +	u32 *response_msg;
> > +	int ret = 0;
> > +
> > +	response_msg = devm_kzalloc(priv->dev,
> > +				    IAP_FEATURE_RESP_SIZE * sizeof(response_msg),
> > +				    GFP_KERNEL);
> > +	if (!response_msg)
> > +		return -ENOMEM;
> > +
> > +	response = devm_kzalloc(priv->dev, sizeof(struct mpfs_mss_response), GFP_KERNEL);
> > +	if (!response) {
> > +		devm_kfree(priv->dev, response_msg);
> > +		return -ENOMEM;
> > +	}
> > +
> > +	message = devm_kzalloc(priv->dev, sizeof(struct mpfs_mss_msg), GFP_KERNEL);
> > +	if (!response) {
> > +		devm_kfree(priv->dev, response_msg);
> > +		devm_kfree(priv->dev, response);
> > +		return -ENOMEM;
> > +	}
> > +
> > +	/*
> > +	 * The system controller can verify that an image in the flash is valid.
> > +	 * Rather than duplicate the check in this driver, call the relevant
> > +	 * service from the system controller instead.
> > +	 * This service has no command data and no response data. It overloads
> > +	 * mbox_offset with the image index in the flash's SPI directory where
> > +	 * the bitstream is located.
> > +	 */
> > +	response->resp_msg = response_msg;
> > +	response->resp_size = IAP_VERIFY_RESP_SIZE;
> > +	message->cmd_opcode = IAP_VERIFY_CMD_OPCODE;
> > +	message->cmd_data_size = IAP_VERIFY_CMD_DATA_SIZE;
> > +	message->response = response;
> > +	message->cmd_data = IAP_VERIFY_CMD_DATA;
> > +	message->mbox_offset = IAP_IMAGE_INDEX;
> > +	message->resp_offset = IAP_DEFAULT_RESP_OFFSET;
> > +
> > +	pr_info("ran IAP_VERIFY_RESP_SIZE\n");
> > +	ret = mpfs_blocking_transaction(priv->sys_controller, message);
> > +	if (ret | response->resp_status) {
> > +		ret = ret ? ret : -EBADMSG;
> > +		goto out;
> > +	}
> > +
> > +	/*
> > +	 * If the validation has passed, initiate IAP.
> > +	 * This service has no command data and no response data. It overloads
> > +	 * mbox_offset with the image index in the flash's SPI directory where
> > +	 * the bitstream is located.
> > +	 * Once we attempt IAP either:
> > +	 * - it passes and the board reboots
> > +	 * - it fails and the board reboots to recover
> > +	 * - the system controller aborts and we exit "gracefully"
> > +	 * This function will never return 0.
> > +	 */
> > +	response->resp_msg = response_msg;
> > +	response->resp_size = IAP_PROGRAM_RESP_SIZE;
> > +	message->cmd_opcode = IAP_PROGRAM_CMD_OPCODE;
> > +	message->cmd_data_size = IAP_PROGRAM_CMD_DATA_SIZE;
> > +	message->response = response;
> > +	message->cmd_data = IAP_PROGRAM_CMD_DATA;
> > +	message->mbox_offset = IAP_IMAGE_INDEX;
> > +	message->resp_offset = IAP_DEFAULT_RESP_OFFSET;
> > +
> > +	pr_info("ran IAP_PROGRAM_CMD_OPCODE\n");
> > +	ret = mpfs_blocking_transaction(priv->sys_controller, message);
> > +	if (ret)
> > +		goto out;
> > +
> > +	/*
> > +	 * This return 0 is dead code. Either the IAP will fail, or it will pass
> > +	 * & the FPGA will be rebooted in which case mpfs_blocking_transaction()
> > +	 * will never return and Linux will die.
> > +	 */
> > +	return 0;
> > +
> > +out:
> > +	devm_kfree(priv->dev, response_msg);
> > +	devm_kfree(priv->dev, response);
> > +	devm_kfree(priv->dev, message);
> > +	return ret;
> > +}
> > +
> > +static const struct fpga_manager_ops mpf_iap_ops = {
> > +	.state = mpf_iap_state,
> > +	.write_init = mpf_iap_write_init,
> > +	.write = mpf_iap_write,
> > +	.write_complete = mpf_iap_write_complete,
> > +};
> > +
> > +static int mpf_iap_run(struct device *dev)
> > +{
> > +	struct fpga_manager *mgr;
> > +	struct fpga_image_info *info;
> > +	int ret;
> > +
> > +	printk("starting to test the fpga manager\n");
> > +
> > +	mgr = fpga_mgr_get(dev);
> > +	info = fpga_image_info_alloc(dev);
> > +
> > +	info->firmware_name = devm_kstrdup(dev, "pf_bitstream.fw", GFP_KERNEL);
> > +	ret = fpga_mgr_lock(mgr);
> > +	if (ret) {
> > +		dev_err(dev, "couldnt lock the manager\n");
> > +		return ret;
> > +	}
> > +
> > +	ret = fpga_mgr_load(mgr, info);
> > +	if (ret) {
> > +		dev_err(dev, "couldnt load the firmware\n");
> > +		return ret;
> > +	}
> > +
> > +	fpga_mgr_unlock(mgr);
> > +	fpga_mgr_put(mgr);
> > +	fpga_image_info_free(info);
> > +
> > +	dev_info(dev, "test complete\n");
> > +
> > +	return ret;
> > +}
> > +
> > +static int mpf_iap_probe(struct platform_device *pdev)
> > +{
> > +	struct device *dev = &pdev->dev;
> > +	struct mpf_iap_priv *priv;
> > +	struct fpga_manager *mgr;
> > +	int ret;
> > +
> > +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > +	if (!priv)
> > +		return -ENOMEM;
> > +
> > +	priv->sys_controller = mpfs_sys_controller_get(dev);
> > +	if (IS_ERR(priv->sys_controller))
> > +		return dev_err_probe(dev, PTR_ERR(priv->sys_controller),
> > +				     "Could not register as a sub device of the system controller\n");
> > +
> > +	priv->dev = dev;
> > +	platform_set_drvdata(pdev, priv);
> > +
> > +	mgr = devm_fpga_mgr_register(dev, "Microchip MPF(S) IAP FPGA Manager",
> > +				     &mpf_iap_ops, priv);
> > +	if (IS_ERR(mgr))
> > +		return dev_err_probe(dev, PTR_ERR(mgr),
> > +				     "Could not register FPGA manager.\n");
> > +
> > +	enum fpga_mgr_states state = mpf_iap_state(mgr);
> > +	//ret = mpf_iap_run(dev);
> > +	ret = 1;
> > +	if (ret)
> > +		dev_err_probe(dev, ret, "IAP failed");
> > +
> > +	dev_info(dev, "Registered Microchip MPF(S) IAP FPGA Manager %u\n", state);
> > +
> > +	return 0;
> > +}
> > +
> > +static struct platform_driver mpf_iap_driver = {
> > +	.driver = {
> > +		.name = "mpfs-iap",
> > +	},
> > +	.probe = mpf_iap_probe,
> > +};
> > +module_platform_driver(mpf_iap_driver);
> > +
> > +MODULE_LICENSE("GPL");
> > +MODULE_AUTHOR("Conor Dooley <conor.dooley@microchip.com>");
> > +MODULE_DESCRIPTION("PolarFire SoC IAP FPGA reprogramming");
> > -- 
> > 2.37.2
> > 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
