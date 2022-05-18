Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD5E352C507
	for <lists+linux-fpga@lfdr.de>; Wed, 18 May 2022 23:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242830AbiERUyt (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 18 May 2022 16:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242788AbiERUyr (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 18 May 2022 16:54:47 -0400
Received: from smtp.smtpout.orange.fr (smtp04.smtpout.orange.fr [80.12.242.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 543A62532EB
        for <linux-fpga@vger.kernel.org>; Wed, 18 May 2022 13:54:45 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.180.246])
        by smtp.orange.fr with ESMTPA
        id rQgqn20Y3QKuarQgqnmO5s; Wed, 18 May 2022 22:54:43 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Wed, 18 May 2022 22:54:43 +0200
X-ME-IP: 86.243.180.246
Message-ID: <6939d35f-36a0-568e-bfec-4dd2e3a48604@wanadoo.fr>
Date:   Wed, 18 May 2022 22:54:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] fpga: altera-cvp: Truncated bitstream error support
Content-Language: en-GB
To:     tien.sung.ang@intel.com, mdf@kernel.org, hao.wu@intel.com,
        yilun.xu@intel.com, trix@redhat.com
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220518064844.2694651-1-tien.sung.ang@intel.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20220518064844.2694651-1-tien.sung.ang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Le 18/05/2022 à 08:48, tien.sung.ang@intel.com a écrit :
> From: Ang Tien Sung <tien.sung.ang@intel.com>
> 
> To support the error handling of a truncated bitstream sent.
> The current AIB CvP firmware is not capable of handling a
> data stream smaller than 4096bytes. The firmware's limitation
> causes a hung-up as it's DMA engine waits forever for the
> completion of the instructed 4096bytes.
> To resolve this design limitation, both firmware and CvP
> driver made several changes. At the CvP driver, we just
> have to ensure that anything lesser than 4096bytes are
> padded with extra bytes. The CvP will then, initiate the
> tear-down by clearing the START_XFER and CVP_CONFIG bits.
> We should also check for CVP_ERROR during the CvP completion.
> A send_buf which is always 4096bytes is used to copy the
> data during every transaction.
> 
> Signed-off-by: Ang Tien Sung <tien.sung.ang@intel.com>
> ---
>   drivers/fpga/altera-cvp.c | 24 +++++++++++++++++++-----
>   1 file changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/fpga/altera-cvp.c b/drivers/fpga/altera-cvp.c
> index 4ffb9da537d8..80edcfb5e5fc 100644
> --- a/drivers/fpga/altera-cvp.c
> +++ b/drivers/fpga/altera-cvp.c
> @@ -81,6 +81,7 @@ struct altera_cvp_conf {
>   	u8			numclks;
>   	u32			sent_packets;
>   	u32			vsec_offset;
> +	u8			*send_buf;
>   	const struct cvp_priv	*priv;
>   };
>   
> @@ -453,7 +454,11 @@ static int altera_cvp_write(struct fpga_manager *mgr, const char *buf,
>   		}
>   
>   		len = min(conf->priv->block_size, remaining);
> -		altera_cvp_send_block(conf, data, len);
> +		/* Copy the requested host data into the transmit buffer */
> +
> +		memcpy(conf->send_buf, data, len);
> +		altera_cvp_send_block(conf, (const u32 *)conf->send_buf,
> +		conf->priv->block_size);

Nitpicking: this should be aligned with 'conf'.

CJ

>   		data += len / sizeof(u32);
>   		done += len;
>   		remaining -= len;

[...]
