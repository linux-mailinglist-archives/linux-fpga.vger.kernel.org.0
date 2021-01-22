Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2392FFC06
	for <lists+linux-fpga@lfdr.de>; Fri, 22 Jan 2021 06:18:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbhAVFRz (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 22 Jan 2021 00:17:55 -0500
Received: from mail-pj1-f43.google.com ([209.85.216.43]:37317 "EHLO
        mail-pj1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbhAVFRx (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 22 Jan 2021 00:17:53 -0500
Received: by mail-pj1-f43.google.com with SMTP id g15so3100443pjd.2;
        Thu, 21 Jan 2021 21:17:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6N5TXJ6yeDofpR8GczZbN8MhQVoOYTknC4OkzyK0VI0=;
        b=qtc6SVgYI9JXzfpBB13nYv/e0Nc1/2vUoivc6Dyvw+5z0u/PgnbXiRDS8BdyhcCr2k
         CoLIl9NwBzZUyfqLCZ68cwFlzGJzzgZYLZFCsOjPanpjjkXQ54rUdD/s/Zr2IKWT2rT2
         C8flRSdyqNofPYfcbTk4t8x6VllQzRQnzJ00VFABca/MFs/YY3YO6h9aJ3WO6mFN33zi
         V1akFw6iJP6kqZq5KApdxRS9NbqtTZRuG9QrwQ5FpOb2v6/2Tio3ExWcAPAHRYAll0S6
         WPy0w/nQVC3mO9Cx7JGWShaaBC6ddalAUtFfAEDshARKLWRgQRfD0+QAK/mhJfTIvWWP
         xh3g==
X-Gm-Message-State: AOAM5327fngw0wKQTx15n7IxRJ897RUK9wXokQo+xexxiwnj8eT57ZiF
        Qun4qrkPDP6OfUTq4064A9M=
X-Google-Smtp-Source: ABdhPJzZqdfEXnKRH17QQSUd97gL9kLCf7mSygNMIaNfZJoW2mQsbnwaUmDee7o4T0jZcW6cZYyOEA==
X-Received: by 2002:a17:90a:de97:: with SMTP id n23mr3405825pjv.216.1611292633004;
        Thu, 21 Jan 2021 21:17:13 -0800 (PST)
Received: from localhost ([2601:647:5b00:1162:1ac0:17a6:4cc6:d1ef])
        by smtp.gmail.com with ESMTPSA id m195sm7585191pfd.215.2021.01.21.21.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 21:17:12 -0800 (PST)
Date:   Thu, 21 Jan 2021 21:17:10 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     Nava kishore Manne <nava.manne@xilinx.com>
Cc:     mdf@kernel.org, trix@redhat.com, robh+dt@kernel.org,
        michal.simek@xilinx.com, linux-fpga@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, git@xilinx.com,
        chinnikishore369@gmail.com
Subject: Re: [PATCH 1/2] fpga: mgr: Adds secure BitStream loading support
Message-ID: <YApf1jlEghbnDFo/@archbook>
References: <20210118025058.10051-1-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210118025058.10051-1-nava.manne@xilinx.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Jan 18, 2021 at 08:20:57AM +0530, Nava kishore Manne wrote:
> This commit adds secure flags to the framework to support
> secure BitStream Loading.
> 
> Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
> ---
>  drivers/fpga/of-fpga-region.c | 10 ++++++++++
>  include/linux/fpga/fpga-mgr.h | 12 ++++++++++++
>  2 files changed, 22 insertions(+)
> 
> diff --git a/drivers/fpga/of-fpga-region.c b/drivers/fpga/of-fpga-region.c
> index e405309baadc..3a5eb4808888 100644
> --- a/drivers/fpga/of-fpga-region.c
> +++ b/drivers/fpga/of-fpga-region.c
> @@ -228,6 +228,16 @@ static struct fpga_image_info *of_fpga_region_parse_ov(
>  	if (of_property_read_bool(overlay, "encrypted-fpga-config"))
>  		info->flags |= FPGA_MGR_ENCRYPTED_BITSTREAM;
>  
> +	if (of_property_read_bool(overlay, "userkey-encrypted-fpga-config"))
> +		info->flags |= FPGA_MGR_USERKEY_ENCRYPTED_BITSTREAM;

Can this just be encrypted-fpga-config/FPGA_MGR_ENCRYPTED?
> +
> +	if (of_property_read_bool(overlay, "ddrmem-authenticated-fpga-config"))
> +		info->flags |= FPGA_MGR_DDR_MEM_AUTH_BITSTREAM;
> +
> +	if (of_property_read_bool(overlay,
> +				  "securemem-authenticated-fpga-config"))
> +		info->flags |= FPGA_MGR_SECURE_MEM_AUTH_BITSTREAM;
> +
>  	if (!of_property_read_string(overlay, "firmware-name",
>  				     &firmware_name)) {
>  		info->firmware_name = devm_kstrdup(dev, firmware_name,
> diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
> index 2bc3030a69e5..2f7455a60666 100644
> --- a/include/linux/fpga/fpga-mgr.h
> +++ b/include/linux/fpga/fpga-mgr.h
> @@ -67,12 +67,24 @@ enum fpga_mgr_states {
>   * %FPGA_MGR_BITSTREAM_LSB_FIRST: SPI bitstream bit order is LSB first
>   *
>   * %FPGA_MGR_COMPRESSED_BITSTREAM: FPGA bitstream is compressed
> + *
> + * %FPGA_MGR_USERKEY_ENCRYPTED_BITSTREAM: indicates bitstream is encrypted with
> + *                                        user key
> + *
> + * %FPGA_MGR_DDR_MEM_AUTH_BITSTREAM: do bitstream authentication using DDR
> + *                                   memory if supported
> + *
> + * %FPGA_MGR_SECURE_MEM_AUTH_BITSTREAM: do bitstream authentication using secure
> + *                                      memory if supported
>   */
>  #define FPGA_MGR_PARTIAL_RECONFIG	BIT(0)
>  #define FPGA_MGR_EXTERNAL_CONFIG	BIT(1)
>  #define FPGA_MGR_ENCRYPTED_BITSTREAM	BIT(2)
>  #define FPGA_MGR_BITSTREAM_LSB_FIRST	BIT(3)
>  #define FPGA_MGR_COMPRESSED_BITSTREAM	BIT(4)
> +#define FPGA_MGR_USERKEY_ENCRYPTED_BITSTREAM	BIT(5)
> +#define FPGA_MGR_DDR_MEM_AUTH_BITSTREAM		BIT(6)
> +#define FPGA_MGR_SECURE_MEM_AUTH_BITSTREAM	BIT(7)
>  
>  /**
>   * struct fpga_image_info - information specific to a FPGA image
> -- 
> 2.18.0
> 

Thanks,
Moritz
