Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB47130514E
	for <lists+linux-fpga@lfdr.de>; Wed, 27 Jan 2021 05:48:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbhA0Epe (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 26 Jan 2021 23:45:34 -0500
Received: from mail-pl1-f171.google.com ([209.85.214.171]:35008 "EHLO
        mail-pl1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbhAZFKO (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 26 Jan 2021 00:10:14 -0500
Received: by mail-pl1-f171.google.com with SMTP id g3so9192112plp.2;
        Mon, 25 Jan 2021 21:09:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=U2R/TNO1t62a1fvRT2+kIDS4atE2rU1hHIrDinhFnIk=;
        b=q8TKMy0OteytCGuCknIP8EjWId0ZeofqlVgzLlE9fm4eg56xKyLcTv6IKcbGuFolfh
         hcHY8V3qD1wsFAAgtaO7rDeU2TWLTk8pliatIMUVdQf84wMoPh4repRp76S2zv+mSnFH
         IhWlHMHrISbZgrBKSrAhj19u4k/UZnR+wwSzYp1anSCwuRMWbH/D6ODSeKAt4njfDl9R
         7wi8PXZJJ7tr4L3kRvpHqJZWZj5BKYzahq7L1c1pbRd537aq8jYAi+ETrFl3OtmO6m43
         53d/F+hoP0jYiuFsBO/zy5QJqGK88Q0/AlAAKqQClJuidkFyz+lZQm3Z6pgNI13t5o2X
         5pBQ==
X-Gm-Message-State: AOAM531IxgrsJr2GiZuM2fqvOthkNZMDiKu5nrMSZ5P6eZs00tUyyeYF
        cYLbvGTfTqQn6aM7Nfd+adI=
X-Google-Smtp-Source: ABdhPJzzY7fLBwR5aJN939asZ2d6vqaQ+9RnFNqdCSdz8mg9wcHrFJi5Kj21kxeqqD1uDRsV0GxGaQ==
X-Received: by 2002:a17:90b:490c:: with SMTP id kr12mr4070809pjb.227.1611637773837;
        Mon, 25 Jan 2021 21:09:33 -0800 (PST)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id 6sm18234164pfz.34.2021.01.25.21.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 21:09:33 -0800 (PST)
Date:   Mon, 25 Jan 2021 21:09:32 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     richard.gong@linux.intel.com
Cc:     mdf@kernel.org, trix@redhat.com, gregkh@linuxfoundation.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        dinguyen@kernel.org, sridhar.rajagopal@intel.com,
        Richard Gong <richard.gong@intel.com>
Subject: Re: [PATCHv3 6/6] fpga: stratix10-soc: extend driver for bitstream
 authentication
Message-ID: <YA+kDJ4gd1VIxQqE@epycbox.lan>
References: <1611608188-25621-1-git-send-email-richard.gong@linux.intel.com>
 <1611608188-25621-7-git-send-email-richard.gong@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1611608188-25621-7-git-send-email-richard.gong@linux.intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Jan 25, 2021 at 02:56:28PM -0600, richard.gong@linux.intel.com wrote:
> From: Richard Gong <richard.gong@intel.com>
> 
> Extend FPGA manager driver to support FPGA bitstream authentication on
> Intel SocFPGA platforms.
> 
> Signed-off-by: Richard Gong <richard.gong@intel.com>
> ---
> v3: add handle to retriev the firmware version to keep driver
>     back compatible
> v2: use flag defined in stratix10-svc driver
> ---
>  drivers/fpga/stratix10-soc.c | 62 +++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 56 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
> index 657a70c..59d738c 100644
> --- a/drivers/fpga/stratix10-soc.c
> +++ b/drivers/fpga/stratix10-soc.c
> @@ -24,6 +24,10 @@
>  #define S10_BUFFER_TIMEOUT (msecs_to_jiffies(SVC_RECONFIG_BUFFER_TIMEOUT_MS))
>  #define S10_RECONFIG_TIMEOUT (msecs_to_jiffies(SVC_RECONFIG_REQUEST_TIMEOUT_MS))
>  
> +#define INVALID_FIRMWARE_VERSION	0xFFFF
> +typedef void (*s10_callback)(struct stratix10_svc_client *client,
> +			     struct stratix10_svc_cb_data *data);
> +
>  /*
>   * struct s10_svc_buf
>   * buf:  virtual address of buf provided by service layer
> @@ -40,11 +44,13 @@ struct s10_priv {
>  	struct completion status_return_completion;
>  	struct s10_svc_buf svc_bufs[NUM_SVC_BUFS];
>  	unsigned long status;
> +	unsigned int fw_version;
>  };
>  
>  static int s10_svc_send_msg(struct s10_priv *priv,
>  			    enum stratix10_svc_command_code command,
> -			    void *payload, u32 payload_length)
> +			    void *payload, u32 payload_length,
> +			    s10_callback callback)
>  {
>  	struct stratix10_svc_chan *chan = priv->chan;
>  	struct device *dev = priv->client.dev;
> @@ -57,6 +63,7 @@ static int s10_svc_send_msg(struct s10_priv *priv,
>  	msg.command = command;
>  	msg.payload = payload;
>  	msg.payload_length = payload_length;
> +	priv->client.receive_cb = callback;
>  
>  	ret = stratix10_svc_send(chan, &msg);
>  	dev_dbg(dev, "stratix10_svc_send returned status %d\n", ret);
> @@ -134,6 +141,29 @@ static void s10_unlock_bufs(struct s10_priv *priv, void *kaddr)
>  }
>  
>  /*
> + * s10_fw_version_callback - callback for the version of running firmware
> + * @client: service layer client struct
> + * @data: message from service layer
> + */
> +static void s10_fw_version_callback(struct stratix10_svc_client *client,
> +				    struct stratix10_svc_cb_data *data)
> +{
> +	struct s10_priv *priv = client->priv;
> +	unsigned int *version = (unsigned int *)data->kaddr1;
> +
> +	if (data->status == BIT(SVC_STATUS_OK))
> +		priv->fw_version = *version;
> +	else if (data->status == BIT(SVC_STATUS_NO_SUPPORT))
> +		dev_warn(client->dev,
> +			 "FW doesn't support bitstream authentication\n");
> +	else
> +		dev_err(client->dev, "Failed to get FW version %lu\n",
> +			BIT(data->status));
> +
> +	complete(&priv->status_return_completion);
> +}
> +
> +/*
>   * s10_receive_callback - callback for service layer to use to provide client
>   * (this driver) messages received through the mailbox.
>   * client: service layer client struct
> @@ -186,13 +216,22 @@ static int s10_ops_write_init(struct fpga_manager *mgr,
>  	if (info->flags & FPGA_MGR_PARTIAL_RECONFIG) {
>  		dev_dbg(dev, "Requesting partial reconfiguration.\n");
>  		ctype.flags |= BIT(COMMAND_RECONFIG_FLAG_PARTIAL);
> +	} else if (info->flags & FPGA_MGR_BITSTREM_AUTHENTICATION) {
BITSTREAM ;-)

Nit: Maybe the flag could be FPGA_MGR_BITSTREAM_AUTHENTICATE and/or
FPGA_MGR_BITSTREAM_AUTH_AND_PERSIST.
> +		if (priv->fw_version == INVALID_FIRMWARE_VERSION) {
> +			dev_err(dev, "FW doesn't support\n");
> +			return -EINVAL;
> +		}
> +
> +		dev_dbg(dev, "Requesting bitstream authentication.\n");
> +		ctype.flags |= BIT(COMMAND_AUTHENTICATE_BITSTREAM);
>  	} else {
>  		dev_dbg(dev, "Requesting full reconfiguration.\n");
>  	}
>  
>  	reinit_completion(&priv->status_return_completion);
>  	ret = s10_svc_send_msg(priv, COMMAND_RECONFIG,
> -			       &ctype, sizeof(ctype));
> +			       &ctype, sizeof(ctype),
> +			       s10_receive_callback);
>  	if (ret < 0)
>  		goto init_done;
>  
> @@ -259,7 +298,7 @@ static int s10_send_buf(struct fpga_manager *mgr, const char *buf, size_t count)
>  	svc_buf = priv->svc_bufs[i].buf;
>  	memcpy(svc_buf, buf, xfer_sz);
>  	ret = s10_svc_send_msg(priv, COMMAND_RECONFIG_DATA_SUBMIT,
> -			       svc_buf, xfer_sz);
> +			       svc_buf, xfer_sz, s10_receive_callback);
>  	if (ret < 0) {
>  		dev_err(dev,
>  			"Error while sending data to service layer (%d)", ret);
> @@ -303,7 +342,7 @@ static int s10_ops_write(struct fpga_manager *mgr, const char *buf,
>  
>  			ret = s10_svc_send_msg(
>  				priv, COMMAND_RECONFIG_DATA_CLAIM,
> -				NULL, 0);
> +				NULL, 0, s10_receive_callback);
>  			if (ret < 0)
>  				break;
>  		}
> @@ -357,7 +396,8 @@ static int s10_ops_write_complete(struct fpga_manager *mgr,
>  	do {
>  		reinit_completion(&priv->status_return_completion);
>  
> -		ret = s10_svc_send_msg(priv, COMMAND_RECONFIG_STATUS, NULL, 0);
> +		ret = s10_svc_send_msg(priv, COMMAND_RECONFIG_STATUS,
> +				       NULL, 0, s10_receive_callback);
>  		if (ret < 0)
>  			break;
>  
> @@ -411,8 +451,9 @@ static int s10_probe(struct platform_device *pdev)
>  	if (!priv)
>  		return -ENOMEM;
>  
> +	priv->fw_version = INVALID_FIRMWARE_VERSION;
>  	priv->client.dev = dev;
> -	priv->client.receive_cb = s10_receive_callback;
> +	priv->client.receive_cb = NULL;
>  	priv->client.priv = priv;
>  
>  	priv->chan = stratix10_svc_request_channel_byname(&priv->client,
> @@ -440,6 +481,15 @@ static int s10_probe(struct platform_device *pdev)
>  		goto probe_err;
>  	}
>  
> +	/* get the running firmware version */
> +	ret = s10_svc_send_msg(priv, COMMAND_FIRMWARE_VERSION,
> +			       NULL, 0, s10_fw_version_callback);
> +	if (ret) {
> +		dev_err(dev, "couldn't get firmware version\n");
> +		fpga_mgr_free(mgr);
> +		goto probe_err;
> +	}
> +
>  	platform_set_drvdata(pdev, mgr);
>  	return ret;
>  
> -- 
> 2.7.4
> 
Thanks,
Moritz
