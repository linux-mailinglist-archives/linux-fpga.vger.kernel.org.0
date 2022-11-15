Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D554A629086
	for <lists+linux-fpga@lfdr.de>; Tue, 15 Nov 2022 04:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbiKODHG (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 14 Nov 2022 22:07:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232503AbiKODGl (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 14 Nov 2022 22:06:41 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642EE205FB;
        Mon, 14 Nov 2022 19:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668481494; x=1700017494;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=lfIuHB3U5ubtRMATztIcj6OQQKv01P1ZszsJXV5uTrE=;
  b=WFoTA4up6f/PBYGquWruX2VkGYz4Xr0OCCanpzN4mx7UWy3VdFe5IltM
   nRraTC1yVT6+jMTN6e6pRRKraIKYY0YDkmw9HET8BUUrcW5zpf+B55YO/
   RmJNMyS+KRWlxQnSc8WzDXrUIa/QBjwsadGLscUYG8a0oyf9zBn9pH1pC
   fwF/lACvd0vlUmo44sCnFtcF6f5PIrvPJ3cMzNhDU0kANaT8kI49usZ+J
   mP7Wo3VHp9oORx9ufIUhFga60Sd1Ee3r+F2fKR2E+1TD0LroCo20wYVCl
   QMww2Duz5UbypjENxJP0N1lgaQwvo6rOOqbUtuppYUnarhvO9l0doFnRm
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="398435094"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="398435094"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 19:04:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="702262030"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="702262030"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga008.fm.intel.com with ESMTP; 14 Nov 2022 19:04:51 -0800
Date:   Tue, 15 Nov 2022 10:55:27 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Russ Weight <russell.h.weight@intel.com>
Cc:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-fpga@vger.kernel.org, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>,
        Lee Jones <lee@kernel.org>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Tianfei zhang <tianfei.zhang@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 06/12] fpga: intel-m10-bmc: Add flash ops for sec update
Message-ID: <Y3L/n28fy0huOe7D@yilunxu-OptiPlex-7050>
References: <20221108144305.45424-1-ilpo.jarvinen@linux.intel.com>
 <20221108144305.45424-7-ilpo.jarvinen@linux.intel.com>
 <Y24K0LGs1tHru4vX@yilunxu-OptiPlex-7050>
 <375b8b75-9de0-6f9c-241e-27d479388fd7@linux.intel.com>
 <Y3HuvXfgA5Tit4YO@yilunxu-OptiPlex-7050>
 <24a29af5-ca9b-38c0-5dce-523104f163d0@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <24a29af5-ca9b-38c0-5dce-523104f163d0@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2022-11-14 at 17:43:01 -0800, Russ Weight wrote:
> 
> 
> On 11/13/22 23:31, Xu Yilun wrote:
> > On 2022-11-11 at 15:32:42 +0200, Ilpo Järvinen wrote:
> >> On Fri, 11 Nov 2022, Xu Yilun wrote:
> >>
> >>> On 2022-11-08 at 16:42:59 +0200, Ilpo Järvinen wrote:
> >>>> Access to flash staging area is different for N6000 from that of the
> >>>> SPI interfaced counterparts. Introduce intel_m10bmc_flash_ops to allow
> >>>> interface specific differentiations for the flash access path for sec
> >>>> update.
> >>>>
> >>>> Co-developed-by: Tianfei zhang <tianfei.zhang@intel.com>
> >>>> Signed-off-by: Tianfei zhang <tianfei.zhang@intel.com>
> >>>> Co-developed-by: Russ Weight <russell.h.weight@intel.com>
> >>>> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> >>>> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> >>>> ---
> >>>>  drivers/fpga/intel-m10-bmc-sec-update.c | 79 ++++++-------------------
> >>>>  drivers/mfd/intel-m10-bmc-spi.c         | 52 ++++++++++++++++
> >>>>  include/linux/mfd/intel-m10-bmc.h       | 14 +++++
> >>>>  3 files changed, 84 insertions(+), 61 deletions(-)
> >>>>
> >>>> diff --git a/drivers/fpga/intel-m10-bmc-sec-update.c b/drivers/fpga/intel-m10-bmc-sec-update.c
> >>>> index dbe8aff95da3..3bd22d03616a 100644
> >>>> --- a/drivers/fpga/intel-m10-bmc-sec-update.c
> >>>> +++ b/drivers/fpga/intel-m10-bmc-sec-update.c
> >>>> @@ -38,11 +38,9 @@ show_root_entry_hash(struct device *dev, u32 exp_magic,
> >>>>  	struct m10bmc_sec *sec = dev_get_drvdata(dev);
> >>>>  	int sha_num_bytes, i, ret, cnt = 0;
> >>>>  	u8 hash[REH_SHA384_SIZE];
> >>>> -	unsigned int stride;
> >>>>  	u32 magic;
> >>>>  
> >>>> -	stride = regmap_get_reg_stride(sec->m10bmc->regmap);
> >>>> -	ret = m10bmc_raw_read(sec->m10bmc, prog_addr, &magic);
> >>>> +	ret = sec->m10bmc->flash_ops->read(sec->m10bmc, (u8 *)&magic, prog_addr, sizeof(magic));
> >>>>  	if (ret)
> >>>>  		return ret;
> >>>>  
> >>>> @@ -50,19 +48,16 @@ show_root_entry_hash(struct device *dev, u32 exp_magic,
> >>>>  		return sysfs_emit(buf, "hash not programmed\n");
> >>>>  
> >>>>  	sha_num_bytes = FIELD_GET(REH_SHA_NUM_BYTES, magic) / 8;
> >>>> -	if ((sha_num_bytes % stride) ||
> >>>> -	    (sha_num_bytes != REH_SHA256_SIZE &&
> >>>> -	     sha_num_bytes != REH_SHA384_SIZE))   {
> >>>> +	if (sha_num_bytes != REH_SHA256_SIZE &&
> >>>> +	    sha_num_bytes != REH_SHA384_SIZE) {
> >>>>  		dev_err(sec->dev, "%s bad sha num bytes %d\n", __func__,
> >>>>  			sha_num_bytes);
> >>>>  		return -EINVAL;
> >>>>  	}
> >>>>  
> >>>> -	ret = regmap_bulk_read(sec->m10bmc->regmap, reh_addr,
> >>>> -			       hash, sha_num_bytes / stride);
> >>>> +	ret = sec->m10bmc->flash_ops->read(sec->m10bmc, hash, reh_addr, sha_num_bytes);
> >>>>  	if (ret) {
> >>>> -		dev_err(dev, "failed to read root entry hash: %x cnt %x: %d\n",
> >>>> -			reh_addr, sha_num_bytes / stride, ret);
> >>>> +		dev_err(dev, "failed to read root entry hash\n");
> >>>>  		return ret;
> >>>>  	}
> >>>>  
> >>>> @@ -98,27 +93,16 @@ DEVICE_ATTR_SEC_REH_RO(pr);
> >>>>  static ssize_t
> >>>>  show_canceled_csk(struct device *dev, u32 addr, char *buf)
> >>>>  {
> >>>> -	unsigned int i, stride, size = CSK_32ARRAY_SIZE * sizeof(u32);
> >>>> +	unsigned int i, size = CSK_32ARRAY_SIZE * sizeof(u32);
> >>>>  	struct m10bmc_sec *sec = dev_get_drvdata(dev);
> >>>>  	DECLARE_BITMAP(csk_map, CSK_BIT_LEN);
> >>>>  	__le32 csk_le32[CSK_32ARRAY_SIZE];
> >>>>  	u32 csk32[CSK_32ARRAY_SIZE];
> >>>>  	int ret;
> >>>>  
> >>>> -	stride = regmap_get_reg_stride(sec->m10bmc->regmap);
> >>>> -	if (size % stride) {
> >>>> -		dev_err(sec->dev,
> >>>> -			"CSK vector size (0x%x) not aligned to stride (0x%x)\n",
> >>>> -			size, stride);
> >>>> -		WARN_ON_ONCE(1);
> >>>> -		return -EINVAL;
> >>>> -	}
> >>>> -
> >>>> -	ret = regmap_bulk_read(sec->m10bmc->regmap, addr, csk_le32,
> >>>> -			       size / stride);
> >>>> +	ret = sec->m10bmc->flash_ops->read(sec->m10bmc, (u8 *)&csk_le32, addr, size);
> >>>>  	if (ret) {
> >>>> -		dev_err(sec->dev, "failed to read CSK vector: %x cnt %x: %d\n",
> >>>> -			addr, size / stride, ret);
> >>>> +		dev_err(sec->dev, "failed to read CSK vector\n");
> >>>>  		return ret;
> >>>>  	}
> >>>>  
> >>>> @@ -157,31 +141,21 @@ static ssize_t flash_count_show(struct device *dev,
> >>>>  {
> >>>>  	struct m10bmc_sec *sec = dev_get_drvdata(dev);
> >>>>  	const struct m10bmc_csr_map *csr_map = sec->m10bmc->info->csr_map;
> >>>> -	unsigned int stride, num_bits;
> >>>> +	unsigned int num_bits;
> >>>>  	u8 *flash_buf;
> >>>>  	int cnt, ret;
> >>>>  
> >>>> -	stride = regmap_get_reg_stride(sec->m10bmc->regmap);
> >>>>  	num_bits = FLASH_COUNT_SIZE * 8;
> >>>>  
> >>>> -	if (FLASH_COUNT_SIZE % stride) {
> >>>> -		dev_err(sec->dev,
> >>>> -			"FLASH_COUNT_SIZE (0x%x) not aligned to stride (0x%x)\n",
> >>>> -			FLASH_COUNT_SIZE, stride);
> >>>> -		WARN_ON_ONCE(1);
> >>>> -		return -EINVAL;
> >>>> -	}
> >>>> -
> >>>>  	flash_buf = kmalloc(FLASH_COUNT_SIZE, GFP_KERNEL);
> >>>>  	if (!flash_buf)
> >>>>  		return -ENOMEM;
> >>>>  
> >>>> -	ret = regmap_bulk_read(sec->m10bmc->regmap, csr_map->rsu_update_counter,
> >>>> -			       flash_buf, FLASH_COUNT_SIZE / stride);
> >>>> +	ret = sec->m10bmc->flash_ops->read(sec->m10bmc, flash_buf,
> >>>> +					   csr_map->rsu_update_counter,
> >>>> +					   FLASH_COUNT_SIZE);
> >>>>  	if (ret) {
> >>>> -		dev_err(sec->dev,
> >>>> -			"failed to read flash count: %x cnt %x: %d\n",
> >>>> -			csr_map->rsu_update_counter, FLASH_COUNT_SIZE / stride, ret);
> >>>> +		dev_err(sec->dev, "failed to read flash count\n");
> >>>>  		goto exit_free;
> >>>>  	}
> >>>>  	cnt = num_bits - bitmap_weight((unsigned long *)flash_buf, num_bits);
> >>>> @@ -470,15 +444,14 @@ static enum fw_upload_err m10bmc_sec_write(struct fw_upload *fwl, const u8 *data
> >>>>  {
> >>>>  	struct m10bmc_sec *sec = fwl->dd_handle;
> >>>>  	const struct m10bmc_csr_map *csr_map = sec->m10bmc->info->csr_map;
> >>>> -	u32 blk_size, doorbell, extra_offset;
> >>>> -	unsigned int stride, extra = 0;
> >>>> +	struct intel_m10bmc *m10bmc = sec->m10bmc;
> >>>> +	u32 blk_size, doorbell;
> >>>>  	int ret;
> >>>>  
> >>>> -	stride = regmap_get_reg_stride(sec->m10bmc->regmap);
> >>>>  	if (sec->cancel_request)
> >>>>  		return rsu_cancel(sec);
> >>>>  
> >>>> -	ret = m10bmc_sys_read(sec->m10bmc, csr_map->doorbell, &doorbell);
> >>>> +	ret = m10bmc_sys_read(m10bmc, csr_map->doorbell, &doorbell);
> >>>>  	if (ret) {
> >>>>  		return FW_UPLOAD_ERR_RW_ERROR;
> >>>>  	} else if (rsu_prog(doorbell) != RSU_PROG_READY) {
> >>>> @@ -486,28 +459,12 @@ static enum fw_upload_err m10bmc_sec_write(struct fw_upload *fwl, const u8 *data
> >>>>  		return FW_UPLOAD_ERR_HW_ERROR;
> >>>>  	}
> >>>>  
> >>>> -	WARN_ON_ONCE(WRITE_BLOCK_SIZE % stride);
> >>>> +	WARN_ON_ONCE(WRITE_BLOCK_SIZE % regmap_get_reg_stride(m10bmc->regmap));
> >>>>  	blk_size = min_t(u32, WRITE_BLOCK_SIZE, size);
> >>>> -	ret = regmap_bulk_write(sec->m10bmc->regmap,
> >>>> -				M10BMC_STAGING_BASE + offset,
> >>>> -				(void *)data + offset,
> >>>> -				blk_size / stride);
> >>>> +	ret = m10bmc->flash_ops->write(m10bmc, data, offset, blk_size);
> >>>>  	if (ret)
> >>>>  		return FW_UPLOAD_ERR_RW_ERROR;
> >>>>  
> >>>> -	/*
> >>>> -	 * If blk_size is not aligned to stride, then handle the extra
> >>>> -	 * bytes with regmap_write.
> >>>> -	 */
> >>>> -	if (blk_size % stride) {
> >>>> -		extra_offset = offset + ALIGN_DOWN(blk_size, stride);
> >>>> -		memcpy(&extra, (u8 *)(data + extra_offset), blk_size % stride);
> >>>> -		ret = regmap_write(sec->m10bmc->regmap,
> >>>> -				   M10BMC_STAGING_BASE + extra_offset, extra);
> >>>> -		if (ret)
> >>>> -			return FW_UPLOAD_ERR_RW_ERROR;
> >>>> -	}
> >>>> -
> >>>>  	*written = blk_size;
> >>>>  	return FW_UPLOAD_ERR_NONE;
> >>>>  }
> >>>> diff --git a/drivers/mfd/intel-m10-bmc-spi.c b/drivers/mfd/intel-m10-bmc-spi.c
> >>>> index e7b0b3b03186..e3b2edb8bc07 100644
> >>>> --- a/drivers/mfd/intel-m10-bmc-spi.c
> >>>> +++ b/drivers/mfd/intel-m10-bmc-spi.c
> >>>> @@ -33,6 +33,57 @@ static struct regmap_config intel_m10bmc_regmap_config = {
> >>>>  	.max_register = M10BMC_MEM_END,
> >>>>  };
> >>>>  
> >>>> +static int m10bmc_spi_flash_write(struct intel_m10bmc *m10bmc, const u8 *buf, u32 offset, u32 size)
> >>>> +{
> >>>> +	unsigned int stride = regmap_get_reg_stride(m10bmc->regmap);
> >>>> +	u32 leftover = size % stride;
> >>>> +	u32 extra_offset, extra = 0;
> >>>> +	int ret;
> >>>> +
> >>>> +	if (WARN_ON_ONCE(stride > sizeof(extra)))
> >>>> +		return -EINVAL;
> >>>> +
> >>>> +	ret = regmap_bulk_write(m10bmc->regmap, M10BMC_STAGING_BASE + offset,
> >>>> +				buf + offset, size / stride);
> >>>> +	if (ret)
> >>>> +		return ret;
> >>>> +
> >>>> +	/* If size is not aligned to stride, then handle the extra bytes with regmap_write */
> >>>> +	if (leftover) {
> >>>> +		extra_offset = offset + ALIGN_DOWN(size, stride);
> >>>> +		memcpy(&extra, (u8 *)(buf + extra_offset), leftover);
> >>>> +
> >>>> +		ret = regmap_write(m10bmc->regmap, M10BMC_STAGING_BASE + extra_offset, extra);
> >>>> +		if (ret)
> >>>> +			return ret;
> >>>> +	}
> >>>> +
> >>>> +	return 0;
> >>>> +}
> >>>> +
> >>>> +static int m10bmc_spi_flash_read(struct intel_m10bmc *m10bmc, u8 *buf, u32 addr, u32 size)
> >>>> +{
> >>>> +	unsigned int stride = regmap_get_reg_stride(m10bmc->regmap);
> >>>> +	int ret;
> >>>> +
> >>>> +	if (WARN_ON_ONCE(size % stride)) {
> >>>> +		dev_err(m10bmc->dev, "read size (0x%x) not aligned to stride (0x%x)\n",
> >>>> +			size, stride);
> >>> Why read should be aligned to stride but write doesn't have to? It's odd that
> >>> same amount of data could be written into flash but can't be read back.
> >> I'll see what needs to be done with this before resubmitting.
> >>
> >>>> +		return -EINVAL;
> >>>> +	}
> >>>> +
> >>>> +	ret = regmap_bulk_read(m10bmc->regmap, addr, buf, size / stride);
> >>>> +	if (ret)
> >>>> +		dev_err(m10bmc->dev, "failed to read flash block data: %x cnt %x: %d\n",
> >>>> +			addr, size / stride, ret);
> >>>> +	return ret;
> >>>> +}
> >>>> +
> >>>> +static const struct intel_m10bmc_flash_ops m10bmc_spi_flash_ops = {
> >>>> +	.read = m10bmc_spi_flash_read,
> >>>> +	.write = m10bmc_spi_flash_write,
> >>>> +};
> >>> Is the flash ops used in other devices? For now, I see it's specific for
> >>> sec-update dev. So why not implement it in sec-update driver?
> >> Are you suggesting the sec-update driver should implement a similar split 
> >> per interface type (SPI/PMCI) as the mfd/bmc one currently does? ...While 
> >> doable, it seems a bit overkill to have that kind of double split.
> > My preference is, try best not to impact MFD driver if a subdev IP is internally
> > changed. For FPGA/CPLD, IP change happens normally. Till now, I see the flash
> > area is dedicated for sec-update dev. So the direct operations for related
> > HW ioaddrs had better be handled by sec-update driver. In case the layout
> > of these HW IO is changed, no need to change the MFD driver.
> >
> > And the PMCI provides an accelerated channel for flash area instead of
> > direct access. It's OK for PMCI MFD driver to implement the acceleration
> > access callbacks, but it is still the sec-update driver's responsibility
> > to decide whether to use it for flash area access.
> 
> Actually, the FIFO interface to the FLASH is the _only_ access path to the
> the FLASH for the PMCI connected BMC. From the perspective of the secure
> update driver, it not a question of choosing the accelerated path or
> the non-accelerated path; it is a question a PMCI BMC connection vs a SPI
> BMC connection.
> 
> If we move these functions into the secure update driver, then we need
> to move the SPI version of these functions into the secure update driver
> as well and add conditionals based on device type, right? IMHO, it seems
> cleaner to split it out they way it is here - less clutter in the secure
> update driver, and the PMCI related functions are not even present if the
> PMCI driver is not needed/installed.

It is cleaner to me that each driver manages its own HW. For me, it is the
secure update driver's job to manage the staging flash directly.

Similarly, the acceleration channel is provided by PMCI. Secure update
driver doesn't have to know how to operate the HW of acceleration channel,
it just need to know whether the channel exists and use it.

Thanks,
Yilun

> 
> - Russ
> 
> >
> > I don't have a solid idea how to implement the accelerated access, maybe
> > some callback in MFD driver, or leverage regmap_bus.write/gather_write?
> >
> > I also have concern about accessing M10BMC_PMCI_FLASH_CTRL in MFD
> > driver, if this register is also dedicated for sec-update.
> >
> > Thanks,
> > Yilun
> >
> >> -- 
> >>  i.
> >>
> >>>>  static int check_m10bmc_version(struct intel_m10bmc *ddata)
> >>>>  {
> >>>>  	unsigned int v;
> >>>> @@ -72,6 +123,7 @@ static int intel_m10_bmc_spi_probe(struct spi_device *spi)
> >>>>  
> >>>>  	info = (struct intel_m10bmc_platform_info *)id->driver_data;
> >>>>  	ddata->dev = dev;
> >>>> +	ddata->flash_ops = &m10bmc_spi_flash_ops;
> >>>>  
> >>>>  	ddata->regmap = devm_regmap_init_spi_avmm(spi, &intel_m10bmc_regmap_config);
> >>>>  	if (IS_ERR(ddata->regmap)) {
> >>>> diff --git a/include/linux/mfd/intel-m10-bmc.h b/include/linux/mfd/intel-m10-bmc.h
> >>>> index d752c0d7cbdb..860408aa8db3 100644
> >>>> --- a/include/linux/mfd/intel-m10-bmc.h
> >>>> +++ b/include/linux/mfd/intel-m10-bmc.h
> >>>> @@ -161,16 +161,30 @@ struct intel_m10bmc_platform_info {
> >>>>  	const struct m10bmc_csr_map *csr_map;
> >>>>  };
> >>>>  
> >>>> +struct intel_m10bmc;
> >>>> +
> >>>> +/**
> >>>> + * struct intel_m10bmc_flash_ops - device specific operations for flash R/W
> >>>> + * @read: read a block of data from flash
> >>>> + * @write: write a block of data to flash
> >>>> + */
> >>>> +struct intel_m10bmc_flash_ops {
> >>>> +	int (*read)(struct intel_m10bmc *m10bmc, u8 *buf, u32 addr, u32 size);
> >>>> +	int (*write)(struct intel_m10bmc *m10bmc, const u8 *buf, u32 offset, u32 size);
> >>>> +};
> >>>> +
> >>>>  /**
> >>>>   * struct intel_m10bmc - Intel MAX 10 BMC parent driver data structure
> >>>>   * @dev: this device
> >>>>   * @regmap: the regmap used to access registers by m10bmc itself
> >>>>   * @info: the platform information for MAX10 BMC
> >>>> + * @flash_ops: optional device specific operations for flash R/W
> >>>>   */
> >>>>  struct intel_m10bmc {
> >>>>  	struct device *dev;
> >>>>  	struct regmap *regmap;
> >>>>  	const struct intel_m10bmc_platform_info *info;
> >>>> +	const struct intel_m10bmc_flash_ops *flash_ops;
> >>> Same concern, maybe implement it in sec-update driver?
> 
