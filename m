Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 576A35370FF
	for <lists+linux-fpga@lfdr.de>; Sun, 29 May 2022 14:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbiE2Mrp (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 29 May 2022 08:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbiE2Mrn (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 29 May 2022 08:47:43 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD1423DDED;
        Sun, 29 May 2022 05:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653828462; x=1685364462;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=s+7BqNjV3zSN78ssKItspdberXNl6VeD4MpmjAbN6dM=;
  b=lz0FG9ZUCX8R+tAATbzGFRraYQZ729Lh1kBHNioFmSnZiYmLlj+jDyct
   SCtQ6+doedg/0tJoMpZZZICukmsec/SkkJBF0trOaWBG1zThY4W97YtBT
   sOJrkwmI7J1iB7o9hU7GS6Bg0Lwzqd/BH9HSeBVQJuAoedDZjzTFOhXw5
   AyqYs7DcH8iRfAA1UUo4UUeo3ksUMolJjtR1UxSjYvPS5sGB+4jLfgkOK
   ojuVJ4Dy2Oy12muNGKVXxG/0i1S1KsADgr5sE8mTn/DmqVTI2clSd8VF6
   zcZ9itVpO88CHTFUC5Ysl62TotQa7+1xj+X7/TTCYBdYd3kwrLvJ+ojwM
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10361"; a="272363024"
X-IronPort-AV: E=Sophos;i="5.91,260,1647327600"; 
   d="scan'208";a="272363024"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2022 05:47:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,260,1647327600"; 
   d="scan'208";a="719524952"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.135])
  by fmsmga001.fm.intel.com with ESMTP; 29 May 2022 05:47:39 -0700
Date:   Sun, 29 May 2022 20:39:54 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Ivan Bornyakov <i.bornyakov@metrotek.ru>
Cc:     mdf@kernel.org, hao.wu@intel.com, trix@redhat.com,
        Conor.Dooley@microchip.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-fpga@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        system@metrotek.ru
Subject: Re: [PATCH v13 2/3] fpga: microchip-spi: add Microchip MPF FPGA
 manager
Message-ID: <20220529123954.GB185904@yilunxu-OptiPlex-7050>
References: <20220526181344.2088-1-i.bornyakov@metrotek.ru>
 <20220526181344.2088-3-i.bornyakov@metrotek.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220526181344.2088-3-i.bornyakov@metrotek.ru>
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, May 26, 2022 at 09:13:43PM +0300, Ivan Bornyakov wrote:
> Add support to the FPGA manager for programming Microchip Polarfire
> FPGAs over slave SPI interface with .dat formatted bitsream image.

From previous mail thread, there are still some hardware operations yet
to be clarified, so I may need a Reviewed-by from Conor.Dooley@microchip.com.

[...]


> +static int mpf_ops_parse_header(struct fpga_manager *mgr,
> +				struct fpga_image_info *info,
> +				const char *buf, size_t count)
> +{
> +	size_t component_size_byte_num, component_size_byte_off,
> +	       components_size_start, bitstream_start, i,
> +	       block_id_offset, block_start_offset;
> +	u8 header_size, blocks_num, block_id;

I think component_size_byte_num, component_size_byte_off, i should be size_t
are all simple numbers irrelated to data size, so maybe u32 is just good.

Thanks,
Yilun

> +	u32 block_start, component_size;
> +	u16 components_num;
> +
> +	if (!buf) {
> +		dev_err(&mgr->dev, "Image buffer is not provided\n");
> +		return -EINVAL;
> +	}
> +
> +	header_size = *(buf + MPF_HEADER_SIZE_OFFSET);
> +	if (header_size > count) {
> +		info->header_size = header_size;
> +		return -EAGAIN;
> +	}
> +
> +	/*
> +	 * Go through look-up table to find out where actual bitstream starts
> +	 * and where sizes of components of the bitstream lies.
> +	 */
> +	blocks_num = *(buf + header_size - 1);
> +	block_id_offset = header_size + MPF_LOOKUP_TABLE_BLOCK_ID_OFFSET;
> +	block_start_offset = header_size + MPF_LOOKUP_TABLE_BLOCK_START_OFFSET;
> +
> +	header_size += blocks_num * MPF_LOOKUP_TABLE_RECORD_SIZE;
> +	if (header_size > count) {
> +		info->header_size = header_size;
> +		return -EAGAIN;
> +	}
> +
> +	components_size_start = 0;
> +	bitstream_start = 0;
> +
> +	while (blocks_num--) {
> +		block_id = *(buf + block_id_offset);
> +		block_start = get_unaligned_le32(buf + block_start_offset);
> +
> +		switch (block_id) {
> +		case MPF_BITSTREAM_ID:
> +			info->header_size = bitstream_start = block_start;
> +			if (block_start > count)
> +				return -EAGAIN;
> +
> +			break;
> +		case MPF_COMPONENTS_SIZE_ID:
> +			components_size_start = block_start;
> +			break;
> +		default:
> +			break;
> +		}
> +
> +		if (bitstream_start && components_size_start)
> +			break;
> +
> +		block_id_offset += MPF_LOOKUP_TABLE_RECORD_SIZE;
> +		block_start_offset += MPF_LOOKUP_TABLE_RECORD_SIZE;
> +	}
> +
> +	if (!bitstream_start || !components_size_start) {
> +		dev_err(&mgr->dev, "Failed to parse header look-up table\n");
> +		return -EFAULT;
> +	}
> +
> +	/*
> +	 * Parse bitstream size.
> +	 * Sizes of components of the bitstream are 22-bits long placed next
> +	 * to each other. Image header should be extended by now up to where
> +	 * actual bitstream starts, so no need for overflow check anymore.
> +	 */
> +	components_num = get_unaligned_le16(buf + MPF_DATA_SIZE_OFFSET);
> +
> +	for (i = 0; i < components_num; i++) {
> +		component_size_byte_num =
> +			(i * MPF_BITS_PER_COMPONENT_SIZE) / BITS_PER_BYTE;
> +		component_size_byte_off =
> +			(i * MPF_BITS_PER_COMPONENT_SIZE) % BITS_PER_BYTE;
> +
> +		component_size = get_unaligned_le32(buf +
> +						    components_size_start +
> +						    component_size_byte_num);
> +		component_size >>= component_size_byte_off;
> +		component_size &= GENMASK(MPF_BITS_PER_COMPONENT_SIZE - 1, 0);
> +
> +		info->data_size += component_size * MPF_SPI_FRAME_SIZE;
> +	}
> +
> +	return 0;
> +}
