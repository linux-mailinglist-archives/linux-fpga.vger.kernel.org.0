Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75E653BD92E
	for <lists+linux-fpga@lfdr.de>; Tue,  6 Jul 2021 16:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232185AbhGFO70 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 6 Jul 2021 10:59:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49820 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232200AbhGFO7J (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 6 Jul 2021 10:59:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625583389;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bmTD9d3ct3Nzqp4lHcZstPNwokD1nD5SFrbRvU2bNOw=;
        b=ZqU4PVBIKdstIHVLcG75qRN4pQP/kSm1HvjW08kcO/dN+pcG9S1OX4aF09IR9sOG5twXMT
        tjL3R1miIKmycEH/Yy51qYl30kAfZ4WDYE43MbJIiJAhKKF8QarCpSevwF1mAW04p1toiS
        4wohB3dgQzIhcCl21Irl2X+JhsgQUKI=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-501-AoR5u345MfS9LW2GpkWvlQ-1; Tue, 06 Jul 2021 10:56:27 -0400
X-MC-Unique: AoR5u345MfS9LW2GpkWvlQ-1
Received: by mail-oo1-f71.google.com with SMTP id c25-20020a4a8f990000b029024c6d57447aso10605627ooj.17
        for <linux-fpga@vger.kernel.org>; Tue, 06 Jul 2021 07:56:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=bmTD9d3ct3Nzqp4lHcZstPNwokD1nD5SFrbRvU2bNOw=;
        b=p32TcG3AvicFggEip+kyFNTm7RZ7bN+QOf0TMN7j44OlSTYl6RrR8+b8dEkMNU4HmV
         NkjkPqwI/Sk6k+Nd961pxhy1xS6x4DdFIiHkvg2ISFPmj5Yiy1lnfI/IqaXwDXHpjJUg
         Hp52ferTM0swWoFdUykx3vsPSdJGD7XzRUD+UWoiV2JkV+UC4kFXTKjGQ1WIwVKeFbiq
         8Zgczf/JXiaocRx8ywmXuBa55dAUGfTpXT63GmoeIb4++9kPF0CXxbccdFAJzLxsPh3W
         tEpznJdkGrHgfesNMttdGJNR2NaxiYdvKjn3hm0m34cGic/PCnptfgGBIyjC7oZjien1
         0d8Q==
X-Gm-Message-State: AOAM533XQGC8B8C8rI1zqnheuNxZXVAUOtYjo/uOstCs81VN5ocZFBHB
        T4NiFN6p23kI9iQRZyL87GVo0MrpSCc0ldcKPt2vDhwncoz/3GknrjDdeDe/BB1Z8j9RX4dHsYa
        LnbrRKUBW6f4P4YJ3nCE7lQ==
X-Received: by 2002:a9d:39e3:: with SMTP id y90mr15636569otb.257.1625583386897;
        Tue, 06 Jul 2021 07:56:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz5dETXDuVxi+74WVF9c6JzTEDL9DAQXIGplmTSwxU4guGmmD+27n0PY+BPl3Ej51FuHkIPvA==
X-Received: by 2002:a9d:39e3:: with SMTP id y90mr15636547otb.257.1625583386688;
        Tue, 06 Jul 2021 07:56:26 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id t5sm3289348otk.39.2021.07.06.07.56.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jul 2021 07:56:26 -0700 (PDT)
Subject: Re: [PATCH v4 2/4] spi: spi-altera-dfl: support n5010 feature
 revision
To:     =?UTF-8?Q?Martin_Hundeb=c3=b8ll?= <martin@geanix.com>,
        Wu Hao <hao.wu@intel.com>, Moritz Fischer <mdf@kernel.org>,
        Xu Yilun <yilun.xu@intel.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>
Cc:     =?UTF-8?Q?Martin_Hundeb=c3=b8ll?= <mhu@silicom.dk>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-spi@vger.kernel.org
References: <20210705101645.2040106-1-martin@geanix.com>
 <20210705101645.2040106-3-martin@geanix.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <d6250f86-db93-bcc2-d46e-6dba30976cc4@redhat.com>
Date:   Tue, 6 Jul 2021 07:56:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210705101645.2040106-3-martin@geanix.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 7/5/21 3:16 AM, Martin Hundebøll wrote:
> From: Martin Hundebøll <mhu@silicom.dk>
>
> The Max10 BMC on the Silicom n5010 PAC is slightly different than the
> existing BMCs, so use a dedicated feature revision detect it.
>
> Signed-off-by: Martin Hundebøll <mhu@silicom.dk>
> Reviewed-by: Moritz Fischer <mdf@kernel.org>
> ---
>
> Changes since v3:
>   * Changed "BMC's" to "BMCs"
>   * Added Moritz' Reviewed-by
>
> Changes since v2:
>   * None
>
> Changes since v1:
>   * use feature revision from struct dfl_device instead of reading it
>     from io-mem
>
>   drivers/spi/spi-altera-dfl.c | 15 +++++++++++++--
>   1 file changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/spi/spi-altera-dfl.c b/drivers/spi/spi-altera-dfl.c
> index 3e32e4fe5895..f6cf7c8d9dac 100644
> --- a/drivers/spi/spi-altera-dfl.c
> +++ b/drivers/spi/spi-altera-dfl.c
> @@ -111,6 +111,13 @@ static struct spi_board_info m10_bmc_info = {
>   	.chip_select = 0,
>   };
>   
> +static struct spi_board_info m10_n5010_bmc_info = {
> +	.modalias = "m10-n5010",
> +	.max_speed_hz = 12500000,
> +	.bus_num = 0,
> +	.chip_select = 0,
> +};

Other then the modalias, this is exactly the same as m10_bmc_info.

Why not set platform_data?

> +
>   static void config_spi_master(void __iomem *base, struct spi_master *master)
>   {
>   	u64 v;
> @@ -130,6 +137,7 @@ static void config_spi_master(void __iomem *base, struct spi_master *master)
>   
>   static int dfl_spi_altera_probe(struct dfl_device *dfl_dev)
>   {
> +	struct spi_board_info *board_info = &m10_bmc_info;
>   	struct device *dev = &dfl_dev->dev;
>   	struct spi_master *master;
>   	struct altera_spi *hw;
> @@ -172,9 +180,12 @@ static int dfl_spi_altera_probe(struct dfl_device *dfl_dev)
>   		goto exit;
>   	}
>   
> -	if (!spi_new_device(master,  &m10_bmc_info)) {
> +	if (dfl_dev->revision == FME_FEATURE_REV_MAX10_SPI_N5010)
> +		board_info = &m10_n5010_bmc_info;

The revision is board parameter, I think this check could be improved.

There should be a

#define FME_FATURE_REV_MAX10_SPI_D5005 0

And it checked here instead of setting above.

And -EINVAL returned if the revision is not known.

> +
> +	if (!spi_new_device(master, board_info)) {
>   		dev_err(dev, "%s failed to create SPI device: %s\n",
> -			__func__, m10_bmc_info.modalias);
> +			__func__, board_info->modalias);

Why isn't this error handled ?

Tom

>   	}
>   
>   	return 0;

