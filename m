Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68CDA4B729D
	for <lists+linux-fpga@lfdr.de>; Tue, 15 Feb 2022 17:42:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240871AbiBOP4N (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 15 Feb 2022 10:56:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240616AbiBOP4M (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 15 Feb 2022 10:56:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9BD1F9F3B2
        for <linux-fpga@vger.kernel.org>; Tue, 15 Feb 2022 07:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644940561;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i3mIIOmXcj6/r/dAaawDN7xnH7QVCOcxOFFmz07jm+Q=;
        b=OT1q3wKoPv90JN00KVgyBTxXXS1dFQFZi7OIwA1PemgCjmqaPjoFKwFLt/hp+nzVGJqBW6
        gvHIdTnElfy+eQkpzaRAgIRg0ZrOkNaYDNa9dcSI8VGPP1sQWwKjaXHfw0c0zGrsddbdXI
        pe/mjNkUwHhDbO1ogaelP6UYiK7YtOM=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-663-_Xc0d32WMoSTAWYOp_tDLg-1; Tue, 15 Feb 2022 10:56:00 -0500
X-MC-Unique: _Xc0d32WMoSTAWYOp_tDLg-1
Received: by mail-ot1-f72.google.com with SMTP id p17-20020a0568301d5100b005a3cd7c1e0bso12453991oth.7
        for <linux-fpga@vger.kernel.org>; Tue, 15 Feb 2022 07:56:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=i3mIIOmXcj6/r/dAaawDN7xnH7QVCOcxOFFmz07jm+Q=;
        b=NcTlXGwFOXqJ45uiJBQd5vKIhyB2W5OUd93ccagPA9ExA7yHhI53upCIaJ3vT3TsUk
         rnJoJ5mXDjPOrtLgZlurIol2NOqicTj0QKhHDFBUtM3hfb1ZCOTacLc0/Nb8gQLZ1Gc8
         oKxK8NoJSV8Ol726pIGk955ipdViSqIo2ncLRubB5AnFBbo9WFSfGnLNMQ5TtImA5DCQ
         E7tQ84EyYM9cJeKnL5Er9cvKqjFcw/hTUt+pxlZcRLXuJbqyD9PePNHlBrFQN8kQ/PCL
         /DnPiT5VSufXsLv61uFJiEEmCRqnjivO6QFUKvBSZFBzfG0nEpXVpwrCSbozR1jG2GVD
         /7uw==
X-Gm-Message-State: AOAM530ljQJcGl0fayhMV+kKd9fmi3r+1yAU+9aVBcHo9kHXAyMMR+SA
        bLmuRXvUXfPpQtW3MfgyTEowNM+wQx9PFX6ipWHuhTOUWZ2Q2x2k3tWVrXQ2FIlDVrt0ge0Tc0s
        7HCx7yRkYGg6juLQIOkPjgQ==
X-Received: by 2002:a05:6808:1205:b0:2ce:6ee7:2ce3 with SMTP id a5-20020a056808120500b002ce6ee72ce3mr1776992oil.273.1644940559465;
        Tue, 15 Feb 2022 07:55:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzT0N7UWtM9bq6RTOfVUzIg8R4uTIT/1lOf1KSFNx+RJEg3jRIhK+L4cRvOG7rSTMshuEG3UQ==
X-Received: by 2002:a05:6808:1205:b0:2ce:6ee7:2ce3 with SMTP id a5-20020a056808120500b002ce6ee72ce3mr1776983oil.273.1644940559280;
        Tue, 15 Feb 2022 07:55:59 -0800 (PST)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id e11sm637030oiw.3.2022.02.15.07.55.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 07:55:58 -0800 (PST)
Subject: Re: [PATCH v1 5/7] drivers: fpga: dfl: handle empty port list
To:     Tianfei zhang <tianfei.zhang@intel.com>, hao.wu@intel.com,
        mdf@kernel.org, yilun.xu@intel.com, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     corbet@lwn.net, Matthew Gerlach <matthew.gerlach@linux.intel.com>
References: <20220214112619.219761-1-tianfei.zhang@intel.com>
 <20220214112619.219761-6-tianfei.zhang@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <6fae1b06-f275-fc11-8a3f-92fd7c666396@redhat.com>
Date:   Tue, 15 Feb 2022 07:55:53 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220214112619.219761-6-tianfei.zhang@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 2/14/22 3:26 AM, Tianfei zhang wrote:
> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>
> Not all FPGA designs managed by the DFL driver have a port.
> In these cases, don't write the Port Access Control register
> when enabling SRIOV.

Drop the 'drivers:' in the subject line.

This patch likely needs to moved to 4/7 since the last patch also 
iterated over the list.

Tom

>
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
> ---
>   drivers/fpga/dfl.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> index cfc539a656f0..a5263ac258c5 100644
> --- a/drivers/fpga/dfl.c
> +++ b/drivers/fpga/dfl.c
> @@ -1708,6 +1708,8 @@ int dfl_fpga_cdev_config_ports_vf(struct dfl_fpga_cdev *cdev, int num_vfs)
>   	int ret = 0, port_count = 0;
>   
>   	mutex_lock(&cdev->lock);
> +	if (list_empty(&cdev->port_dev_list))
> +		goto done;
>   
>   	list_for_each_entry(pdata, &cdev->port_dev_list, node) {
>   		if (pdata->dev)

