Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB8FE3B69EB
	for <lists+linux-fpga@lfdr.de>; Mon, 28 Jun 2021 22:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237320AbhF1U5o (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 28 Jun 2021 16:57:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36734 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235419AbhF1U5n (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 28 Jun 2021 16:57:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624913716;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fvk4x+VinAixB3G6n6FpTbrtUNoyle0i26UtXK2mtuE=;
        b=aQVVdafIjAwHDbUhz8hCBvey0N0yqZuBILEuml7HuYLPJu2GJyQL5modZracQuWDrU1+pC
        VrbjEf9NrFVuizQ39A4UpIqq2r36hXKHZTDzXC8LGci1fMZxthGpbloYxzOv3THUj2sXAF
        TG+o+gkr7INUpbVZ6C5499Xo2UxY/c4=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-570-FEfhOtI7PWuKhQt17YIUXA-1; Mon, 28 Jun 2021 16:55:15 -0400
X-MC-Unique: FEfhOtI7PWuKhQt17YIUXA-1
Received: by mail-oo1-f72.google.com with SMTP id 3-20020a4a03030000b029024950bdb69dso12389895ooi.3
        for <linux-fpga@vger.kernel.org>; Mon, 28 Jun 2021 13:55:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Fvk4x+VinAixB3G6n6FpTbrtUNoyle0i26UtXK2mtuE=;
        b=nY6jLtt0pABNkq2MPcbmtd1VXASAyO/N54nq9OX6FHW721+YkQNSkFFjOIf+QcaGYg
         3Y0f+0nbX5j4/FkXhNNj8tHsZXdLEsRLIuF5f0Q9thnHJ9WOcJKwBPFOgftcCpYoLqFH
         WaPDUeT7G8BB0ZFD4iicXGKnmT8reP9tGWSQCy31kd0kJcELeJFiBxM1LmNBFjpKrceQ
         4TS+vxb5N4TcpW9LlWnBUfhi274hDsXjyc2StiAphZLxa4UsJoAzjH1uKThWAct3bq5U
         +7Ga+wLHMzdCtS/MPb7feihO9hgFkpWNi+csL8j0Kz8twizCEJ0Bad2xq92QOZG6/Qk5
         2+WQ==
X-Gm-Message-State: AOAM530Nef5HfyiqESvhQDZEC/EpLypubZ98uKs0+GKwx5do1Egs63NR
        G1ILrmvAccsJiYD+8wZ4gsv9p5oHrY8OVgFOrPexdJNZK3wZsPSGmS0E4Goa/tSUuaBe24dxxKr
        SMwyGqDYvxSCwo97cOQQnpw==
X-Received: by 2002:a05:6830:1387:: with SMTP id d7mr1324732otq.61.1624913714320;
        Mon, 28 Jun 2021 13:55:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJywtnw9JjTD1I1X6Niim3Fd29IEU5mVDoiu4yRl9I63dOZ35GczDfx93iPw14PNFjNZJ/wb5A==
X-Received: by 2002:a05:6830:1387:: with SMTP id d7mr1324703otq.61.1624913714025;
        Mon, 28 Jun 2021 13:55:14 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id f138sm3426063oig.21.2021.06.28.13.55.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jun 2021 13:55:13 -0700 (PDT)
Subject: Re: [PATCH v5 1/4] fpga: generalize updating the card
To:     Moritz Fischer <mdf@kernel.org>,
        Russ Weight <russell.h.weight@intel.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     hao.wu@intel.com, michal.simek@xilinx.com,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20210625195849.837976-1-trix@redhat.com>
 <20210625195849.837976-3-trix@redhat.com> <YNoYhAjh0vydP5yF@epycbox.lan>
From:   Tom Rix <trix@redhat.com>
Message-ID: <a333a01e-e705-5f07-e1a0-2362e947a879@redhat.com>
Date:   Mon, 28 Jun 2021 13:55:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YNoYhAjh0vydP5yF@epycbox.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 6/28/21 11:44 AM, Moritz Fischer wrote:
> On Fri, Jun 25, 2021 at 12:58:46PM -0700, trix@redhat.com wrote:
>> From: Tom Rix <trix@redhat.com>
>>
>> There is a need to update the whole card.  An fpga can
> Not sure I'd use the 'card' language. Not every FPGA sits on a plugin
> card / board.
>
> I'd suggest to frame the description around persistent vs
> non-persistent.
>
>> contain non-fpga components whose firmware needs to be
>> updated at the same time as the fpga rtl images and
>> may need to be handled differently from the existing
>> fpga reconfiguration in the fpga manager.
> Updating images beyond FPGA images is beyond the scope of the FPGA
> Manager framework.

This patchset is a followup for the sec-mgr patchset, seeing if 
generalizing fpga-mgr makes sense.

If it doesn't, that is fine we can drop this.


I believe a contentious part of sec-mgr patchset is its a single user 
feature being implemented as a general subsystem feature.

If generalizing fpga-mgr is out, the options as I see it are.

keep sec-mgr structure as-is.

move card updating to fw subsystem

have a dfl-sec-update.* dfl specific interface in fpga/ .

Tom


>> Move the write_* ops out of fpga_manager_ops and
>> into a new fpga_manager_update_ops struct.  Add
>> two update_ops back to fpga_manager_ops,
>> reconfig for the exiting functionality and
>> reimage for the new functionity.
>>
>> Rewire fpga devs to use reconfig ops
>>
>> Signed-off-by: Tom Rix <trix@redhat.com>
>> ---
>>   drivers/fpga/altera-cvp.c        |  8 ++++----
>>   drivers/fpga/altera-pr-ip-core.c |  8 ++++----
>>   drivers/fpga/altera-ps-spi.c     |  8 ++++----
>>   drivers/fpga/dfl-fme-mgr.c       |  8 ++++----
>>   drivers/fpga/fpga-mgr.c          | 20 ++++++++++----------
>>   drivers/fpga/ice40-spi.c         |  8 ++++----
>>   drivers/fpga/machxo2-spi.c       |  8 ++++----
>>   drivers/fpga/socfpga-a10.c       | 10 +++++-----
>>   drivers/fpga/socfpga.c           |  8 ++++----
>>   drivers/fpga/stratix10-soc.c     |  6 +++---
>>   drivers/fpga/ts73xx-fpga.c       |  6 +++---
>>   drivers/fpga/xilinx-spi.c        |  8 ++++----
>>   drivers/fpga/zynq-fpga.c         | 10 +++++-----
>>   drivers/fpga/zynqmp-fpga.c       |  6 +++---
>>   include/linux/fpga/fpga-mgr.h    | 32 +++++++++++++++++++++-----------
>>   15 files changed, 82 insertions(+), 72 deletions(-)
>>
>> diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
>> index ccf4546eff297..9363353798bc9 100644
>> --- a/drivers/fpga/altera-cvp.c
>> +++ b/drivers/fpga/altera-cvp.c
>> @@ -516,10 +516,10 @@ static int altera_cvp_write_complete(struct fpga_manager *mgr,
>>   }
>>   
>>   static const struct fpga_manager_ops altera_cvp_ops = {
>> -	.state		= altera_cvp_state,
>> -	.write_init	= altera_cvp_write_init,
>> -	.write		= altera_cvp_write,
>> -	.write_complete	= altera_cvp_write_complete,
>> +	.state                   = altera_cvp_state,
>> +	.reconfig.write_init     = altera_cvp_write_init,
>> +	.reconfig.write          = altera_cvp_write,
>> +	.reconfig.write_complete = altera_cvp_write_complete,
>>   };
>>   
>>   static const struct cvp_priv cvp_priv_v1 = {
>> diff --git a/drivers/fpga/altera-pr-ip-core.c b/drivers/fpga/altera-pr-ip-core.c
>> index dfdf21ed34c4e..30c7b534df95b 100644
>> --- a/drivers/fpga/altera-pr-ip-core.c
>> +++ b/drivers/fpga/altera-pr-ip-core.c
>> @@ -167,10 +167,10 @@ static int alt_pr_fpga_write_complete(struct fpga_manager *mgr,
>>   }
>>   
>>   static const struct fpga_manager_ops alt_pr_ops = {
>> -	.state = alt_pr_fpga_state,
>> -	.write_init = alt_pr_fpga_write_init,
>> -	.write = alt_pr_fpga_write,
>> -	.write_complete = alt_pr_fpga_write_complete,
>> +	.state                   = alt_pr_fpga_state,
>> +	.reconfig.write_init     = alt_pr_fpga_write_init,
>> +	.reconfig.write          = alt_pr_fpga_write,
>> +	.reconfig.write_complete = alt_pr_fpga_write_complete,
>>   };
>>   
>>   int alt_pr_register(struct device *dev, void __iomem *reg_base)
>> diff --git a/drivers/fpga/altera-ps-spi.c b/drivers/fpga/altera-ps-spi.c
>> index 23bfd4d1ad0f7..2b01a3c53d374 100644
>> --- a/drivers/fpga/altera-ps-spi.c
>> +++ b/drivers/fpga/altera-ps-spi.c
>> @@ -231,10 +231,10 @@ static int altera_ps_write_complete(struct fpga_manager *mgr,
>>   }
>>   
>>   static const struct fpga_manager_ops altera_ps_ops = {
>> -	.state = altera_ps_state,
>> -	.write_init = altera_ps_write_init,
>> -	.write = altera_ps_write,
>> -	.write_complete = altera_ps_write_complete,
>> +	.state                   = altera_ps_state,
>> +	.reconfig.write_init     = altera_ps_write_init,
>> +	.reconfig.write          = altera_ps_write,
>> +	.reconfig.write_complete = altera_ps_write_complete,
>>   };
>>   
>>   static const struct altera_ps_data *id_to_data(const struct spi_device_id *id)
>> diff --git a/drivers/fpga/dfl-fme-mgr.c b/drivers/fpga/dfl-fme-mgr.c
>> index 313420405d5e8..a6d2ed399e580 100644
>> --- a/drivers/fpga/dfl-fme-mgr.c
>> +++ b/drivers/fpga/dfl-fme-mgr.c
>> @@ -260,10 +260,10 @@ static u64 fme_mgr_status(struct fpga_manager *mgr)
>>   }
>>   
>>   static const struct fpga_manager_ops fme_mgr_ops = {
>> -	.write_init = fme_mgr_write_init,
>> -	.write = fme_mgr_write,
>> -	.write_complete = fme_mgr_write_complete,
>> -	.status = fme_mgr_status,
>> +	.status                  = fme_mgr_status,
>> +	.reconfig.write_init     = fme_mgr_write_init,
>> +	.reconfig.write          = fme_mgr_write,
>> +	.reconfig.write_complete = fme_mgr_write_complete,
>>   };
>>   
>>   static void fme_mgr_get_compat_id(void __iomem *fme_pr,
>> diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
>> index aa30889e23208..31c51d7e07cc8 100644
>> --- a/drivers/fpga/fpga-mgr.c
>> +++ b/drivers/fpga/fpga-mgr.c
>> @@ -47,8 +47,8 @@ static inline u64 fpga_mgr_status(struct fpga_manager *mgr)
>>   
>>   static inline int fpga_mgr_write(struct fpga_manager *mgr, const char *buf, size_t count)
>>   {
>> -	if (mgr->mops->write)
>> -		return  mgr->mops->write(mgr, buf, count);
>> +	if (mgr->mops->reconfig.write)
>> +		return  mgr->mops->reconfig.write(mgr, buf, count);
>>   	return -EOPNOTSUPP;
>>   }
>>   
>> @@ -62,8 +62,8 @@ static inline int fpga_mgr_write_complete(struct fpga_manager *mgr,
>>   	int ret = 0;
>>   
>>   	mgr->state = FPGA_MGR_STATE_WRITE_COMPLETE;
>> -	if (mgr->mops->write_complete)
>> -		ret = mgr->mops->write_complete(mgr, info);
>> +	if (mgr->mops->reconfig.write_complete)
>> +		ret = mgr->mops->reconfig.write_complete(mgr, info);
>>   	if (ret) {
>>   		dev_err(&mgr->dev, "Error after writing image data to FPGA\n");
>>   		mgr->state = FPGA_MGR_STATE_WRITE_COMPLETE_ERR;
>> @@ -78,16 +78,16 @@ static inline int fpga_mgr_write_init(struct fpga_manager *mgr,
>>   				      struct fpga_image_info *info,
>>   				      const char *buf, size_t count)
>>   {
>> -	if (mgr->mops->write_init)
>> -		return  mgr->mops->write_init(mgr, info, buf, count);
>> +	if (mgr->mops->reconfig.write_init)
>> +		return  mgr->mops->reconfig.write_init(mgr, info, buf, count);
>>   	return 0;
>>   }
>>   
>>   static inline int fpga_mgr_write_sg(struct fpga_manager *mgr,
>>   				    struct sg_table *sgt)
>>   {
>> -	if (mgr->mops->write_sg)
>> -		return  mgr->mops->write_sg(mgr, sgt);
>> +	if (mgr->mops->reconfig.write_sg)
>> +		return  mgr->mops->reconfig.write_sg(mgr, sgt);
>>   	return -EOPNOTSUPP;
>>   }
>>   
>> @@ -232,7 +232,7 @@ static int fpga_mgr_buf_load_sg(struct fpga_manager *mgr,
>>   
>>   	/* Write the FPGA image to the FPGA. */
>>   	mgr->state = FPGA_MGR_STATE_WRITE;
>> -	if (mgr->mops->write_sg) {
>> +	if (mgr->mops->reconfig.write_sg) {
>>   		ret = fpga_mgr_write_sg(mgr, sgt);
>>   	} else {
>>   		struct sg_mapping_iter miter;
>> @@ -309,7 +309,7 @@ static int fpga_mgr_buf_load(struct fpga_manager *mgr,
>>   	 * contiguous kernel buffer and the driver doesn't require SG, non-SG
>>   	 * drivers will still work on the slow path.
>>   	 */
>> -	if (mgr->mops->write)
>> +	if (mgr->mops->reconfig.write)
>>   		return fpga_mgr_buf_load_mapped(mgr, info, buf, count);
>>   
>>   	/*
>> diff --git a/drivers/fpga/ice40-spi.c b/drivers/fpga/ice40-spi.c
>> index 69dec5af23c36..3bdc3fe8ece97 100644
>> --- a/drivers/fpga/ice40-spi.c
>> +++ b/drivers/fpga/ice40-spi.c
>> @@ -126,10 +126,10 @@ static int ice40_fpga_ops_write_complete(struct fpga_manager *mgr,
>>   }
>>   
>>   static const struct fpga_manager_ops ice40_fpga_ops = {
>> -	.state = ice40_fpga_ops_state,
>> -	.write_init = ice40_fpga_ops_write_init,
>> -	.write = ice40_fpga_ops_write,
>> -	.write_complete = ice40_fpga_ops_write_complete,
>> +	.state                   = ice40_fpga_ops_state,
>> +	.reconfig.write_init     = ice40_fpga_ops_write_init,
>> +	.reconfig.write          = ice40_fpga_ops_write,
>> +	.reconfig.write_complete = ice40_fpga_ops_write_complete,
>>   };
>>   
>>   static int ice40_fpga_probe(struct spi_device *spi)
>> diff --git a/drivers/fpga/machxo2-spi.c b/drivers/fpga/machxo2-spi.c
>> index 114a64d2b7a4d..8b860e9a19c92 100644
>> --- a/drivers/fpga/machxo2-spi.c
>> +++ b/drivers/fpga/machxo2-spi.c
>> @@ -350,10 +350,10 @@ static int machxo2_write_complete(struct fpga_manager *mgr,
>>   }
>>   
>>   static const struct fpga_manager_ops machxo2_ops = {
>> -	.state = machxo2_spi_state,
>> -	.write_init = machxo2_write_init,
>> -	.write = machxo2_write,
>> -	.write_complete = machxo2_write_complete,
>> +	.state                   = machxo2_spi_state,
>> +	.reconfig.write_init     = machxo2_write_init,
>> +	.reconfig.write          = machxo2_write,
>> +	.reconfig.write_complete = machxo2_write_complete,
>>   };
>>   
>>   static int machxo2_spi_probe(struct spi_device *spi)
>> diff --git a/drivers/fpga/socfpga-a10.c b/drivers/fpga/socfpga-a10.c
>> index 573d88bdf7307..e60bf844b4c40 100644
>> --- a/drivers/fpga/socfpga-a10.c
>> +++ b/drivers/fpga/socfpga-a10.c
>> @@ -458,11 +458,11 @@ static enum fpga_mgr_states socfpga_a10_fpga_state(struct fpga_manager *mgr)
>>   }
>>   
>>   static const struct fpga_manager_ops socfpga_a10_fpga_mgr_ops = {
>> -	.initial_header_size = (RBF_DECOMPRESS_OFFSET + 1) * 4,
>> -	.state = socfpga_a10_fpga_state,
>> -	.write_init = socfpga_a10_fpga_write_init,
>> -	.write = socfpga_a10_fpga_write,
>> -	.write_complete = socfpga_a10_fpga_write_complete,
>> +	.initial_header_size     = (RBF_DECOMPRESS_OFFSET + 1) * 4,
>> +	.state                   = socfpga_a10_fpga_state,
>> +	.reconfig.write_init     = socfpga_a10_fpga_write_init,
>> +	.reconfig.write          = socfpga_a10_fpga_write,
>> +	.reconfig.write_complete = socfpga_a10_fpga_write_complete,
>>   };
>>   
>>   static int socfpga_a10_fpga_probe(struct platform_device *pdev)
>> diff --git a/drivers/fpga/socfpga.c b/drivers/fpga/socfpga.c
>> index 1f467173fc1f3..cc752a3f742c2 100644
>> --- a/drivers/fpga/socfpga.c
>> +++ b/drivers/fpga/socfpga.c
>> @@ -534,10 +534,10 @@ static enum fpga_mgr_states socfpga_fpga_ops_state(struct fpga_manager *mgr)
>>   }
>>   
>>   static const struct fpga_manager_ops socfpga_fpga_ops = {
>> -	.state = socfpga_fpga_ops_state,
>> -	.write_init = socfpga_fpga_ops_configure_init,
>> -	.write = socfpga_fpga_ops_configure_write,
>> -	.write_complete = socfpga_fpga_ops_configure_complete,
>> +	.state                   = socfpga_fpga_ops_state,
>> +	.reconfig.write_init     = socfpga_fpga_ops_configure_init,
>> +	.reconfig.write          = socfpga_fpga_ops_configure_write,
>> +	.reconfig.write_complete = socfpga_fpga_ops_configure_complete,
>>   };
>>   
>>   static int socfpga_fpga_probe(struct platform_device *pdev)
>> diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
>> index 047fd7f237069..ab1941d92cf60 100644
>> --- a/drivers/fpga/stratix10-soc.c
>> +++ b/drivers/fpga/stratix10-soc.c
>> @@ -389,9 +389,9 @@ static int s10_ops_write_complete(struct fpga_manager *mgr,
>>   }
>>   
>>   static const struct fpga_manager_ops s10_ops = {
>> -	.write_init = s10_ops_write_init,
>> -	.write = s10_ops_write,
>> -	.write_complete = s10_ops_write_complete,
>> +	.reconfig.write_init     = s10_ops_write_init,
>> +	.reconfig.write          = s10_ops_write,
>> +	.reconfig.write_complete = s10_ops_write_complete,
>>   };
>>   
>>   static int s10_probe(struct platform_device *pdev)
>> diff --git a/drivers/fpga/ts73xx-fpga.c b/drivers/fpga/ts73xx-fpga.c
>> index 167abb0b08d40..cbbc6dec56856 100644
>> --- a/drivers/fpga/ts73xx-fpga.c
>> +++ b/drivers/fpga/ts73xx-fpga.c
>> @@ -93,9 +93,9 @@ static int ts73xx_fpga_write_complete(struct fpga_manager *mgr,
>>   }
>>   
>>   static const struct fpga_manager_ops ts73xx_fpga_ops = {
>> -	.write_init	= ts73xx_fpga_write_init,
>> -	.write		= ts73xx_fpga_write,
>> -	.write_complete	= ts73xx_fpga_write_complete,
>> +	.reconfig.write_init     = ts73xx_fpga_write_init,
>> +	.reconfig.write          = ts73xx_fpga_write,
>> +	.reconfig.write_complete = ts73xx_fpga_write_complete,
>>   };
>>   
>>   static int ts73xx_fpga_probe(struct platform_device *pdev)
>> diff --git a/drivers/fpga/xilinx-spi.c b/drivers/fpga/xilinx-spi.c
>> index fee4d0abf6bfe..4d092f30bf700 100644
>> --- a/drivers/fpga/xilinx-spi.c
>> +++ b/drivers/fpga/xilinx-spi.c
>> @@ -214,10 +214,10 @@ static int xilinx_spi_write_complete(struct fpga_manager *mgr,
>>   }
>>   
>>   static const struct fpga_manager_ops xilinx_spi_ops = {
>> -	.state = xilinx_spi_state,
>> -	.write_init = xilinx_spi_write_init,
>> -	.write = xilinx_spi_write,
>> -	.write_complete = xilinx_spi_write_complete,
>> +	.state                   = xilinx_spi_state,
>> +	.reconfig.write_init     = xilinx_spi_write_init,
>> +	.reconfig.write          = xilinx_spi_write,
>> +	.reconfig.write_complete = xilinx_spi_write_complete,
>>   };
>>   
>>   static int xilinx_spi_probe(struct spi_device *spi)
>> diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
>> index 9b75bd4f93d8e..bdfc257740cff 100644
>> --- a/drivers/fpga/zynq-fpga.c
>> +++ b/drivers/fpga/zynq-fpga.c
>> @@ -543,11 +543,11 @@ static enum fpga_mgr_states zynq_fpga_ops_state(struct fpga_manager *mgr)
>>   }
>>   
>>   static const struct fpga_manager_ops zynq_fpga_ops = {
>> -	.initial_header_size = 128,
>> -	.state = zynq_fpga_ops_state,
>> -	.write_init = zynq_fpga_ops_write_init,
>> -	.write_sg = zynq_fpga_ops_write,
>> -	.write_complete = zynq_fpga_ops_write_complete,
>> +	.initial_header_size     = 128,
>> +	.state                   = zynq_fpga_ops_state,
>> +	.reconfig.write_init     = zynq_fpga_ops_write_init,
>> +	.reconfig.write_sg       = zynq_fpga_ops_write,
>> +	.reconfig.write_complete = zynq_fpga_ops_write_complete,
>>   };
>>   
>>   static int zynq_fpga_probe(struct platform_device *pdev)
>> diff --git a/drivers/fpga/zynqmp-fpga.c b/drivers/fpga/zynqmp-fpga.c
>> index 9efbd70aa6864..fbb66c1f9c871 100644
>> --- a/drivers/fpga/zynqmp-fpga.c
>> +++ b/drivers/fpga/zynqmp-fpga.c
>> @@ -78,9 +78,9 @@ static enum fpga_mgr_states zynqmp_fpga_ops_state(struct fpga_manager *mgr)
>>   }
>>   
>>   static const struct fpga_manager_ops zynqmp_fpga_ops = {
>> -	.state = zynqmp_fpga_ops_state,
>> -	.write_init = zynqmp_fpga_ops_write_init,
>> -	.write = zynqmp_fpga_ops_write,
>> +	.state                   = zynqmp_fpga_ops_state,
>> +	.reconfig.write_init     = zynqmp_fpga_ops_write_init,
>> +	.reconfig.write          = zynqmp_fpga_ops_write,
>>   };
>>   
>>   static int zynqmp_fpga_probe(struct platform_device *pdev)
>> diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
>> index 474c1f5063070..53f9402d6aa17 100644
>> --- a/include/linux/fpga/fpga-mgr.h
>> +++ b/include/linux/fpga/fpga-mgr.h
>> @@ -106,14 +106,29 @@ struct fpga_image_info {
>>   };
>>   
>>   /**
>> - * struct fpga_manager_ops - ops for low level fpga manager drivers
>> - * @initial_header_size: Maximum number of bytes that should be passed into write_init
>> - * @state: returns an enum value of the FPGA's state
>> - * @status: returns status of the FPGA, including reconfiguration error code
>> + * struct fpga_manager_update_ops - ops updating fpga
>>    * @write_init: prepare the FPGA to receive configuration data
>>    * @write: write count bytes of configuration data to the FPGA
>>    * @write_sg: write the scatter list of configuration data to the FPGA
>>    * @write_complete: set FPGA to operating state after writing is done
>> + */
>> +struct fpga_manager_update_ops {
>> +	int (*write_init)(struct fpga_manager *mgr,
>> +			  struct fpga_image_info *info,
>> +			  const char *buf, size_t count);
>> +	int (*write)(struct fpga_manager *mgr, const char *buf, size_t count);
>> +	int (*write_sg)(struct fpga_manager *mgr, struct sg_table *sgt);
>> +	int (*write_complete)(struct fpga_manager *mgr,
>> +			      struct fpga_image_info *info);
>> +};
>> +
>> +/**
>> + * struct fpga_manager_ops - ops for low level fpga manager drivers
>> + * @initial_header_size: Maximum number of bytes that should be passed into write_init
>> + * @state: returns an enum value of the FPGA's state
>> + * @status: returns status of the FPGA, including reconfiguration error code
>> + * @partial_update: ops for doing partial reconfiguration
>> + * @full_update: ops for doing a full card update, user,shell,fw ie. the works
>>    * @fpga_remove: optional: Set FPGA into a specific state during driver remove
>>    * @groups: optional attribute groups.
>>    *
>> @@ -125,13 +140,8 @@ struct fpga_manager_ops {
>>   	size_t initial_header_size;
>>   	enum fpga_mgr_states (*state)(struct fpga_manager *mgr);
>>   	u64 (*status)(struct fpga_manager *mgr);
>> -	int (*write_init)(struct fpga_manager *mgr,
>> -			  struct fpga_image_info *info,
>> -			  const char *buf, size_t count);
>> -	int (*write)(struct fpga_manager *mgr, const char *buf, size_t count);
>> -	int (*write_sg)(struct fpga_manager *mgr, struct sg_table *sgt);
>> -	int (*write_complete)(struct fpga_manager *mgr,
>> -			      struct fpga_image_info *info);
>> +	struct fpga_manager_update_ops reconfig;
>> +	struct fpga_manager_update_ops reimage;
>>   	void (*fpga_remove)(struct fpga_manager *mgr);
>>   	const struct attribute_group **groups;
>>   };
>> -- 
>> 2.26.3
>>
> Thanks,
> Moritz
>

