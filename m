Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E21C53E35D
	for <lists+linux-fpga@lfdr.de>; Mon,  6 Jun 2022 10:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbiFFHhG (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 6 Jun 2022 03:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbiFFHhC (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 6 Jun 2022 03:37:02 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B45124BCF;
        Mon,  6 Jun 2022 00:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654501019; x=1686037019;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0+iLG7eOycsTs/4xxdmC2P3X7oWOpMhJTLrvcfVpS98=;
  b=HfiBIEqQtYByt2ODFc3IJMPhRYdE5qvbn+bXJXLoyXAGWdoIH/uLIuTt
   6v6d6l99HbPS5BQdNB0X07enfY/uwS/jxWyaBRJrHtkidPa/M51em47TU
   z/q5HIuebbl1Yv6NTx2lFC3DZn16Gq+VpvZhk7ekvgm2W9Ad/j97uFAv2
   qUAHs3YSgWGUig3V5td89iGw8qEY2ah6SH90INjWeeKLdEfOzpsLVzZdZ
   U3wR2AJsGVV+LpaSS6WU7Yha5hEbJte2opqvK0572nY9Xe4ODG0fQBQ/f
   qYBmddQzu2RREN8C0uvsPk2nkDlSKe5Z7nY3CmnLLLXyn/si1WyLPR1Mw
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10369"; a="337456161"
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="337456161"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 00:36:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="583493055"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.135])
  by fmsmga007.fm.intel.com with ESMTP; 06 Jun 2022 00:36:56 -0700
Date:   Mon, 6 Jun 2022 15:29:03 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Ivan Bornyakov <i.bornyakov@metrotek.ru>
Cc:     mdf@kernel.org, hao.wu@intel.com, trix@redhat.com,
        Conor.Dooley@microchip.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-fpga@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        system@metrotek.ru
Subject: Re: [PATCH v15 2/3] fpga: microchip-spi: add Microchip MPF FPGA
  manager
Message-ID: <20220606072903.GA249875@yilunxu-OptiPlex-7050>
References: <20220602084550.4380-1-i.bornyakov@metrotek.ru>
 <20220602084550.4380-3-i.bornyakov@metrotek.ru>
 <20220604162721.GB243326@yilunxu-OptiPlex-7050>
 <20220604182633.p2t2tdisjz43ztbp@x260>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220604182633.p2t2tdisjz43ztbp@x260>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Sat, Jun 04, 2022 at 09:26:33PM +0300, Ivan Bornyakov wrote:
> On Sun, Jun 05, 2022 at 12:27:21AM +0800, Xu Yilun wrote:
> > On Thu, Jun 02, 2022 at 11:45:49AM +0300, Ivan Bornyakov wrote:
> > > Add support to the FPGA manager for programming Microchip Polarfire
> > > FPGAs over slave SPI interface with .dat formatted bitsream image.
> > > 
> > > Signed-off-by: Ivan Bornyakov <i.bornyakov@metrotek.ru>
> > > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > > Tested-by: Conor Dooley <conor.dooley@microchip.com>
> > > ---
> > >  drivers/fpga/Kconfig         |   9 +
> > >  drivers/fpga/Makefile        |   1 +
> > >  drivers/fpga/microchip-spi.c | 391 +++++++++++++++++++++++++++++++++++
> > >  3 files changed, 401 insertions(+)
> > >  create mode 100644 drivers/fpga/microchip-spi.c
> > > 
> > > diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> > > index 26025dbab353..75806ef5c9ea 100644
> > > --- a/drivers/fpga/Kconfig
> > > +++ b/drivers/fpga/Kconfig
> > > @@ -248,4 +248,13 @@ config FPGA_MGR_VERSAL_FPGA
> > >  	  configure the programmable logic(PL).
> > >  
> > >  	  To compile this as a module, choose M here.
> > > +
> > > +config FPGA_MGR_MICROCHIP_SPI
> > > +	tristate "Microchip Polarfire SPI FPGA manager"
> > > +	depends on SPI
> > > +	help
> > > +	  FPGA manager driver support for Microchip Polarfire FPGAs
> > > +	  programming over slave SPI interface with .dat formatted
> > > +	  bitstream image.
> > > +
> > >  endif # FPGA
> > > diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
> > > index e32bfa90f968..5425a15892df 100644
> > > --- a/drivers/fpga/Makefile
> > > +++ b/drivers/fpga/Makefile
> > > @@ -19,6 +19,7 @@ obj-$(CONFIG_FPGA_MGR_XILINX_SPI)	+= xilinx-spi.o
> > >  obj-$(CONFIG_FPGA_MGR_ZYNQ_FPGA)	+= zynq-fpga.o
> > >  obj-$(CONFIG_FPGA_MGR_ZYNQMP_FPGA)	+= zynqmp-fpga.o
> > >  obj-$(CONFIG_FPGA_MGR_VERSAL_FPGA)	+= versal-fpga.o
> > > +obj-$(CONFIG_FPGA_MGR_MICROCHIP_SPI)	+= microchip-spi.o
> > >  obj-$(CONFIG_ALTERA_PR_IP_CORE)		+= altera-pr-ip-core.o
> > >  obj-$(CONFIG_ALTERA_PR_IP_CORE_PLAT)	+= altera-pr-ip-core-plat.o
> > >  
> > > diff --git a/drivers/fpga/microchip-spi.c b/drivers/fpga/microchip-spi.c
> > > new file mode 100644
> > > index 000000000000..1980d12292dc
> > > --- /dev/null
> > > +++ b/drivers/fpga/microchip-spi.c
> > > @@ -0,0 +1,391 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Microchip Polarfire FPGA programming over slave SPI interface.
> > > + */
> > > +
> > > +#include <asm/unaligned.h>
> > > +#include <linux/delay.h>
> > > +#include <linux/fpga/fpga-mgr.h>
> > > +#include <linux/module.h>
> > > +#include <linux/of_device.h>
> > > +#include <linux/spi/spi.h>
> > > +
> > > +#define	MPF_SPI_ISC_ENABLE	0x0B
> > > +#define	MPF_SPI_ISC_DISABLE	0x0C
> > > +#define	MPF_SPI_READ_STATUS	0x00
> > > +#define	MPF_SPI_READ_DATA	0x01
> > > +#define	MPF_SPI_FRAME_INIT	0xAE
> > > +#define	MPF_SPI_FRAME		0xEE
> > > +#define	MPF_SPI_PRG_MODE	0x01
> > > +#define	MPF_SPI_RELEASE		0x23
> > > +
> > > +#define	MPF_SPI_FRAME_SIZE	16
> > > +
> > > +#define	MPF_HEADER_SIZE_OFFSET	24
> > > +#define	MPF_DATA_SIZE_OFFSET	55
> > > +
> > > +#define	MPF_LOOKUP_TABLE_RECORD_SIZE		9
> > > +#define	MPF_LOOKUP_TABLE_BLOCK_ID_OFFSET	0
> > > +#define	MPF_LOOKUP_TABLE_BLOCK_START_OFFSET	1
> > > +
> > > +#define	MPF_COMPONENTS_SIZE_ID	5
> > > +#define	MPF_BITSTREAM_ID	8
> > > +
> > > +#define	MPF_BITS_PER_COMPONENT_SIZE	22
> > > +
> > > +#define	MPF_STATUS_POLL_RETRIES		10000
> > > +#define	MPF_STATUS_BUSY			BIT(0)
> > > +#define	MPF_STATUS_READY		BIT(1)
> > > +#define	MPF_STATUS_SPI_VIOLATION	BIT(2)
> > > +#define	MPF_STATUS_SPI_ERROR		BIT(3)
> > > +
> > > +struct mpf_priv {
> > > +	struct spi_device *spi;
> > > +	bool program_mode;
> > > +};
> > > +
> > > +static int mpf_read_status(struct spi_device *spi)
> > > +{
> > > +	u8 status = 0, status_command = MPF_SPI_READ_STATUS;
> > > +	struct spi_transfer xfers[2] = { 0 };
> > > +	int ret;
> > > +
> > > +	/*
> > > +	 * HW status is returned on MISO in the first byte after CS went
> > > +	 * active. However, first reading can be inadequate, so we submit
> > > +	 * two identical SPI transfers and use result of the later one.
> > > +	 */
> > > +	xfers[0].tx_buf = xfers[1].tx_buf = &status_command;
> > > +	xfers[0].rx_buf = xfers[1].rx_buf = &status;
> > > +	xfers[0].len = xfers[1].len = 1;
> > > +	xfers[0].cs_change = 1;
> > > +
> > > +	ret = spi_sync_transfer(spi, xfers, 2);
> > > +
> > > +	if ((status & MPF_STATUS_SPI_VIOLATION) ||
> > > +	    (status & MPF_STATUS_SPI_ERROR))
> > > +		ret = -EIO;
> > > +
> > > +	return ret ? : status;
> > > +}
> > > +
> > > +static enum fpga_mgr_states mpf_ops_state(struct fpga_manager *mgr)
> > > +{
> > > +	struct mpf_priv *priv = mgr->priv;
> > > +	struct spi_device *spi;
> > > +	bool program_mode;
> > > +	int status;
> > > +
> > > +	spi = priv->spi;
> > > +	program_mode = priv->program_mode;
> > > +	status = mpf_read_status(spi);
> > > +
> > > +	if (!program_mode && !status)
> > > +		return FPGA_MGR_STATE_OPERATING;
> > > +
> > > +	return FPGA_MGR_STATE_UNKNOWN;
> > > +}
> > > +
> > > +static int mpf_ops_parse_header(struct fpga_manager *mgr,
> > > +				struct fpga_image_info *info,
> > > +				const char *buf, size_t count)
> > > +{
> > > +	size_t component_size_byte_num, component_size_byte_off,
> > > +	       block_id_offset, block_start_offset;
> > > +	u8 header_size, blocks_num, block_id;
> > > +	u32 block_start, component_size, i,
> > > +	    components_size_start = 0,
> > > +	    bitstream_start = 0;
> > 
> > In last mail, I meant component_size_byte_num, component_size_byte_off
> > could be u32.
> > 
> > component_size_start, bitstream_start are for the offsets to image,
> > size_t is OK.
> > 
> > Any concern on your side?
> 
> component_size_byte_num is used along with component_size_start as byte
> index in image buffer.
> 
> component_size_byte_off is used as shift index, as components sizes are
> 22 bits long and shift is needed.
> 
> I really don't see any advantage of u32 or size_t for any of these
> variables, that's why I used size_t for all of them originally, as a
> safe bet.

I see, thanks. So please stick to your original style, using size_t for
them, except 'u16 i', is that OK?

Thanks,
Yilun

> 
> > 
> > Others look good to me.
> > 
> > Thanks,
> > Yilun
> > 
> > > +	u16 components_num;
> > > +
> > > +	if (!buf) {
> > > +		dev_err(&mgr->dev, "Image buffer is not provided\n");
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	header_size = *(buf + MPF_HEADER_SIZE_OFFSET);
> > > +	if (header_size > count) {
> > > +		info->header_size = header_size;
> > > +		return -EAGAIN;
> > > +	}
> > > +
> > > +	/*
> > > +	 * Go through look-up table to find out where actual bitstream starts
> > > +	 * and where sizes of components of the bitstream lies.
> > > +	 */
> > > +	blocks_num = *(buf + header_size - 1);
> > > +	block_id_offset = header_size + MPF_LOOKUP_TABLE_BLOCK_ID_OFFSET;
> > > +	block_start_offset = header_size + MPF_LOOKUP_TABLE_BLOCK_START_OFFSET;
> > > +
> > > +	header_size += blocks_num * MPF_LOOKUP_TABLE_RECORD_SIZE;
> > > +	if (header_size > count) {
> > > +		info->header_size = header_size;
> > > +		return -EAGAIN;
> > > +	}
> > > +
> > > +	while (blocks_num--) {
> > > +		block_id = *(buf + block_id_offset);
> > > +		block_start = get_unaligned_le32(buf + block_start_offset);
> > > +
> > > +		switch (block_id) {
> > > +		case MPF_BITSTREAM_ID:
> > > +			info->header_size = bitstream_start = block_start;
> > > +			if (block_start > count)
> > > +				return -EAGAIN;
> > > +
> > > +			break;
> > > +		case MPF_COMPONENTS_SIZE_ID:
> > > +			components_size_start = block_start;
> > > +			break;
> > > +		default:
> > > +			break;
> > > +		}
> > > +
> > > +		if (bitstream_start && components_size_start)
> > > +			break;
> > > +
> > > +		block_id_offset += MPF_LOOKUP_TABLE_RECORD_SIZE;
> > > +		block_start_offset += MPF_LOOKUP_TABLE_RECORD_SIZE;
> > > +	}
> > > +
> > > +	if (!bitstream_start || !components_size_start) {
> > > +		dev_err(&mgr->dev, "Failed to parse header look-up table\n");
> > > +		return -EFAULT;
> > > +	}
> > > +
> > > +	/*
> > > +	 * Parse bitstream size.
> > > +	 * Sizes of components of the bitstream are 22-bits long placed next
> > > +	 * to each other. Image header should be extended by now up to where
> > > +	 * actual bitstream starts, so no need for overflow check anymore.
> > > +	 */
> > > +	components_num = get_unaligned_le16(buf + MPF_DATA_SIZE_OFFSET);
> > > +
> > > +	for (i = 0; i < components_num; i++) {
> > > +		component_size_byte_num =
> > > +			(i * MPF_BITS_PER_COMPONENT_SIZE) / BITS_PER_BYTE;
> > > +		component_size_byte_off =
> > > +			(i * MPF_BITS_PER_COMPONENT_SIZE) % BITS_PER_BYTE;
> > > +
> > > +		component_size = get_unaligned_le32(buf +
> > > +						    components_size_start +
> > > +						    component_size_byte_num);
> > > +		component_size >>= component_size_byte_off;
> > > +		component_size &= GENMASK(MPF_BITS_PER_COMPONENT_SIZE - 1, 0);
> > > +
> > > +		info->data_size += component_size * MPF_SPI_FRAME_SIZE;
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +/* Poll HW status until busy bit is cleared and mask bits are set. */
> > > +static int mpf_poll_status(struct spi_device *spi, u8 mask)
> > > +{
> > > +	int status, retries = MPF_STATUS_POLL_RETRIES;
> > > +
> > > +	while (retries--) {
> > > +		status = mpf_read_status(spi);
> > > +		if (status < 0)
> > > +			return status;
> > > +
> > > +		if (status & MPF_STATUS_BUSY)
> > > +			continue;
> > > +
> > > +		if (!mask || (status & mask))
> > > +			return status;
> > > +	}
> > > +
> > > +	return -EBUSY;
> > > +}
> > > +
> > > +static int mpf_spi_write(struct spi_device *spi, const void *buf, size_t buf_size)
> > > +{
> > > +	int status = mpf_poll_status(spi, 0);
> > > +
> > > +	if (status < 0)
> > > +		return status;
> > > +
> > > +	return spi_write(spi, buf, buf_size);
> > > +}
> > > +
> > > +static int mpf_spi_write_then_read(struct spi_device *spi,
> > > +				   const void *txbuf, size_t txbuf_size,
> > > +				   void *rxbuf, size_t rxbuf_size)
> > > +{
> > > +	const u8 read_command[] = { MPF_SPI_READ_DATA };
> > > +	int ret;
> > > +
> > > +	ret = mpf_spi_write(spi, txbuf, txbuf_size);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	ret = mpf_poll_status(spi, MPF_STATUS_READY);
> > > +	if (ret < 0)
> > > +		return ret;
> > > +
> > > +	return spi_write_then_read(spi, read_command, sizeof(read_command),
> > > +				   rxbuf, rxbuf_size);
> > > +}
> > > +
> > > +static int mpf_ops_write_init(struct fpga_manager *mgr,
> > > +			      struct fpga_image_info *info, const char *buf,
> > > +			      size_t count)
> > > +{
> > > +	const u8 program_mode[] = { MPF_SPI_FRAME_INIT, MPF_SPI_PRG_MODE };
> > > +	const u8 isc_en_command[] = { MPF_SPI_ISC_ENABLE };
> > > +	struct mpf_priv *priv = mgr->priv;
> > > +	struct device *dev = &mgr->dev;
> > > +	struct spi_device *spi;
> > > +	u32 isc_ret = 0;
> > > +	int ret;
> > > +
> > > +	if (info->flags & FPGA_MGR_PARTIAL_RECONFIG) {
> > > +		dev_err(dev, "Partial reconfiguration is not supported\n");
> > > +		return -EOPNOTSUPP;
> > > +	}
> > > +
> > > +	spi = priv->spi;
> > > +
> > > +	ret = mpf_spi_write_then_read(spi, isc_en_command, sizeof(isc_en_command),
> > > +				      &isc_ret, sizeof(isc_ret));
> > > +	if (ret || isc_ret) {
> > > +		dev_err(dev, "Failed to enable ISC: spi_ret %d, isc_ret %u\n",
> > > +			ret, isc_ret);
> > > +		return -EFAULT;
> > > +	}
> > > +
> > > +	ret = mpf_spi_write(spi, program_mode, sizeof(program_mode));
> > > +	if (ret) {
> > > +		dev_err(dev, "Failed to enter program mode: %d\n", ret);
> > > +		return ret;
> > > +	}
> > > +
> > > +	priv->program_mode = true;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int mpf_ops_write(struct fpga_manager *mgr, const char *buf, size_t count)
> > > +{
> > > +	u8 spi_frame_command[] = { MPF_SPI_FRAME };
> > > +	struct spi_transfer xfers[2] = { 0 };
> > > +	struct mpf_priv *priv = mgr->priv;
> > > +	struct device *dev = &mgr->dev;
> > > +	struct spi_device *spi;
> > > +	int ret, i;
> > > +
> > > +	if (count % MPF_SPI_FRAME_SIZE) {
> > > +		dev_err(dev, "Bitstream size is not a multiple of %d\n",
> > > +			MPF_SPI_FRAME_SIZE);
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	spi = priv->spi;
> > > +
> > > +	xfers[0].tx_buf = spi_frame_command;
> > > +	xfers[0].len = sizeof(spi_frame_command);
> > > +
> > > +	for (i = 0; i < count / MPF_SPI_FRAME_SIZE; i++) {
> > > +		xfers[1].tx_buf = buf + i * MPF_SPI_FRAME_SIZE;
> > > +		xfers[1].len = MPF_SPI_FRAME_SIZE;
> > > +
> > > +		ret = mpf_poll_status(spi, 0);
> > > +		if (ret >= 0)
> > > +			ret = spi_sync_transfer(spi, xfers, ARRAY_SIZE(xfers));
> > > +
> > > +		if (ret) {
> > > +			dev_err(dev, "Failed to write bitstream frame %d/%zu\n",
> > > +				i, count / MPF_SPI_FRAME_SIZE);
> > > +			return ret;
> > > +		}
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int mpf_ops_write_complete(struct fpga_manager *mgr,
> > > +				  struct fpga_image_info *info)
> > > +{
> > > +	const u8 isc_dis_command[] = { MPF_SPI_ISC_DISABLE };
> > > +	const u8 release_command[] = { MPF_SPI_RELEASE };
> > > +	struct mpf_priv *priv = mgr->priv;
> > > +	struct device *dev = &mgr->dev;
> > > +	struct spi_device *spi;
> > > +	int ret;
> > > +
> > > +	spi = priv->spi;
> > > +
> > > +	ret = mpf_spi_write(spi, isc_dis_command, sizeof(isc_dis_command));
> > > +	if (ret) {
> > > +		dev_err(dev, "Failed to disable ISC: %d\n", ret);
> > > +		return ret;
> > > +	}
> > > +
> > > +	usleep_range(1000, 2000);
> > > +
> > > +	ret = mpf_spi_write(spi, release_command, sizeof(release_command));
> > > +	if (ret) {
> > > +		dev_err(dev, "Failed to exit program mode: %d\n", ret);
> > > +		return ret;
> > > +	}
> > > +
> > > +	priv->program_mode = false;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static const struct fpga_manager_ops mpf_ops = {
> > > +	.state = mpf_ops_state,
> > > +	.initial_header_size = 71,
> > > +	.parse_header = mpf_ops_parse_header,
> > > +	.write_init = mpf_ops_write_init,
> > > +	.write = mpf_ops_write,
> > > +	.write_complete = mpf_ops_write_complete,
> > > +};
> > > +
> > > +static int mpf_probe(struct spi_device *spi)
> > > +{
> > > +	struct device *dev = &spi->dev;
> > > +	struct fpga_manager *mgr;
> > > +	struct mpf_priv *priv;
> > > +
> > > +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > > +	if (!priv)
> > > +		return -ENOMEM;
> > > +
> > > +	priv->spi = spi;
> > > +
> > > +	mgr = devm_fpga_mgr_register(dev, "Microchip Polarfire SPI FPGA Manager",
> > > +				     &mpf_ops, priv);
> > > +
> > > +	return PTR_ERR_OR_ZERO(mgr);
> > > +}
> > > +
> > > +static const struct spi_device_id mpf_spi_ids[] = {
> > > +	{ .name = "mpf-spi-fpga-mgr", },
> > > +	{},
> > > +};
> > > +MODULE_DEVICE_TABLE(spi, mpf_spi_ids);
> > > +
> > > +#if IS_ENABLED(CONFIG_OF)
> > > +static const struct of_device_id mpf_of_ids[] = {
> > > +	{ .compatible = "microchip,mpf-spi-fpga-mgr" },
> > > +	{},
> > > +};
> > > +MODULE_DEVICE_TABLE(of, mpf_of_ids);
> > > +#endif /* IS_ENABLED(CONFIG_OF) */
> > > +
> > > +static struct spi_driver mpf_driver = {
> > > +	.probe = mpf_probe,
> > > +	.id_table = mpf_spi_ids,
> > > +	.driver = {
> > > +		.name = "microchip_mpf_spi_fpga_mgr",
> > > +		.of_match_table = of_match_ptr(mpf_of_ids),
> > > +	},
> > > +};
> > > +
> > > +module_spi_driver(mpf_driver);
> > > +
> > > +MODULE_DESCRIPTION("Microchip Polarfire SPI FPGA Manager");
> > > +MODULE_LICENSE("GPL");
> > > -- 
> > > 2.35.1
> > > 
