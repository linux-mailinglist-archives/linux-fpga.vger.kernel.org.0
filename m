Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 349AD3DAC66
	for <lists+linux-fpga@lfdr.de>; Thu, 29 Jul 2021 22:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232659AbhG2UFc (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 29 Jul 2021 16:05:32 -0400
Received: from mail-pl1-f174.google.com ([209.85.214.174]:37807 "EHLO
        mail-pl1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbhG2UFb (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 29 Jul 2021 16:05:31 -0400
Received: by mail-pl1-f174.google.com with SMTP id n10so8284281plf.4;
        Thu, 29 Jul 2021 13:05:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=N4XpPMhj5Tkma5XUAaZR+M6J4EuxWf5VI78KdNDzLXs=;
        b=DzYY/RngENLyUwN6s+uQobPMeuWs/0Ddhwg+5djGx2KAXXtC5xrdzUj2emCRYthpDz
         BVgIlX4JsqUkAh1jHVg9+JkZz2tgaVDfkXDKBRcK2rdV6Ib/Qm3iOC/CoLTrvrH5mi2Z
         QG0+xRQmt3NH0rCSgtBm2yNPmCGOfQGmSsAIT76dwgYsJsjjGM2fy8P9/oFBV5StXm8l
         a/1PBIIy8vfz1QQWYoFIHT7W6bGed0CHHVOByXHzN3SrPC2wctXgPspfxS4SkVHMhCJv
         WTaWG7NeWBuwoq7X19W9eMZoTuGOEHD0k3M+Ub60mNMAhUdSS7CR/8fowr2potKTJPhd
         Mprw==
X-Gm-Message-State: AOAM530vfY4xWK9hUVC1DTWuh3OU89CZmQGapxmAZ/J7yLsJ49+RbFmw
        dmlw4P7UH0Jf7bCN4Kjq+Ko=
X-Google-Smtp-Source: ABdhPJzWpkYP5SMsVQmIIP1u5Iq42oT/tDAun8eUW3qrlkaD9OgWq/vl26IOj3pCETylSLJfZ6qvUA==
X-Received: by 2002:a65:5083:: with SMTP id r3mr5247237pgp.161.1627589127660;
        Thu, 29 Jul 2021 13:05:27 -0700 (PDT)
Received: from localhost ([2601:647:5b00:6f70:be34:681b:b1e9:776f])
        by smtp.gmail.com with ESMTPSA id q21sm4856804pgk.71.2021.07.29.13.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 13:05:26 -0700 (PDT)
Date:   Thu, 29 Jul 2021 13:05:25 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Tom Rix <trix@redhat.com>
Cc:     Martin =?iso-8859-1?Q?Hundeb=F8ll?= <martin@geanix.com>,
        Wu Hao <hao.wu@intel.com>, Moritz Fischer <mdf@kernel.org>,
        Xu Yilun <yilun.xu@intel.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Mark Brown <broonie@kernel.org>,
        Martin =?iso-8859-1?Q?Hundeb=F8ll?= <mhu@silicom.dk>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v5 2/3] spi: spi-altera-dfl: support n5010 feature
 revision
Message-ID: <YQMKBQw99T/hlAfX@epycbox.lan>
References: <20210716135441.3235863-1-martin@geanix.com>
 <20210716135441.3235863-3-martin@geanix.com>
 <be04e83e-bdf7-3a5c-ff34-a7cbf91f6ba2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <be04e83e-bdf7-3a5c-ff34-a7cbf91f6ba2@redhat.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Fri, Jul 16, 2021 at 01:44:45PM -0700, Tom Rix wrote:
> 
> On 7/16/21 6:54 AM, Martin Hundebøll wrote:
> > From: Martin Hundebøll <mhu@silicom.dk>
> > 
> > The Max10 BMC on the Silicom n5010 PAC is slightly different than the
> > existing BMCs, so use a dedicated feature revision detect it.
> > 
> > Signed-off-by: Martin Hundebøll <mhu@silicom.dk>
> > Reviewed-by: Moritz Fischer <mdf@kernel.org>
> > ---
> > 
> > Changes since v4:
> >   * Moved spi board_info structure from global/static scope
> >     to function/stack scope
> > 
> > Changes since v3:
> >   * Changed "BMC's" to "BMCs"
> >   * Added Moritz' Reviewed-by
> > 
> > Changes since v2:
> >   * None
> > 
> > Changes since v1:
> >   * use feature revision from struct dfl_device instead of reading it
> >     from io-mem
> > 
> >   drivers/spi/spi-altera-dfl.c | 21 ++++++++++++---------
> >   1 file changed, 12 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/spi/spi-altera-dfl.c b/drivers/spi/spi-altera-dfl.c
> > index 39a3e1a032e0..44fc9ee13fc7 100644
> > --- a/drivers/spi/spi-altera-dfl.c
> > +++ b/drivers/spi/spi-altera-dfl.c
> > @@ -104,13 +104,6 @@ static const struct regmap_config indirect_regbus_cfg = {
> >   	.reg_read = indirect_bus_reg_read,
> >   };
> > -static struct spi_board_info m10_bmc_info = {
> > -	.modalias = "m10-d5005",
> > -	.max_speed_hz = 12500000,
> > -	.bus_num = 0,
> > -	.chip_select = 0,
> > -};
> > -
> >   static void config_spi_master(void __iomem *base, struct spi_master *master)
> >   {
> >   	u64 v;
> > @@ -130,6 +123,7 @@ static void config_spi_master(void __iomem *base, struct spi_master *master)
> >   static int dfl_spi_altera_probe(struct dfl_device *dfl_dev)
> >   {
> > +	struct spi_board_info board_info = { 0 };
> >   	struct device *dev = &dfl_dev->dev;
> >   	struct spi_master *master;
> >   	struct altera_spi *hw;
> > @@ -170,9 +164,18 @@ static int dfl_spi_altera_probe(struct dfl_device *dfl_dev)
> >   		goto exit;
> >   	}
> > -	if (!spi_new_device(master,  &m10_bmc_info)) {
> > +	if (dfl_dev->revision == FME_FEATURE_REV_MAX10_SPI_N5010)
> > +		strscpy(board_info.modalias, "m10-n5010", SPI_NAME_SIZE);
> > +	else
> > +		strscpy(board_info.modalias, "m10-d5005", SPI_NAME_SIZE);
> > +
> > +	board_info.max_speed_hz = 12500000;
> > +	board_info.bus_num = 0;
> > +	board_info.chip_select = 0;
> > +
> > +	if (!spi_new_device(master, &board_info)) {
> >   		dev_err(dev, "%s failed to create SPI device: %s\n",
> > -			__func__, m10_bmc_info.modalias);
> > +			__func__, board_info.modalias);
> >   	}
> 
> Looks good to me.
> 
> Reviewed-by: Tom Rix <trix@redhat.com>
> 
> >   	return 0;
> 
Applied to for-next,

Thanks
