Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 392894B7062
	for <lists+linux-fpga@lfdr.de>; Tue, 15 Feb 2022 17:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239476AbiBOOvi (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 15 Feb 2022 09:51:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239153AbiBOOvZ (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 15 Feb 2022 09:51:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0153F11942B
        for <linux-fpga@vger.kernel.org>; Tue, 15 Feb 2022 06:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644936551;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AQuhuF7IKOqYCKxv1Xz0llTmBI5LAygxnXZl/GDmFGk=;
        b=IhfFGrrz01EQcj/B0bm6rusNoI+jK/sbGM+My3OBtRMZQwTDPfzZuI60YGQGchB3MBVUsh
        /Oa9BhF/WFRFuJv+3P0mivmG9ziiZkAVdpYAXGKOFNfpu3cfC9+yHzc0fHOPY2MCLzDrGv
        0nD4JQyuUsT2OUtO/BoGaFb75prAlVg=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-260-LNGQyCk5OP65EXXEjn72yQ-1; Tue, 15 Feb 2022 09:49:10 -0500
X-MC-Unique: LNGQyCk5OP65EXXEjn72yQ-1
Received: by mail-ot1-f72.google.com with SMTP id e21-20020a9d7315000000b005a6d56ac70bso12325559otk.21
        for <linux-fpga@vger.kernel.org>; Tue, 15 Feb 2022 06:49:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=AQuhuF7IKOqYCKxv1Xz0llTmBI5LAygxnXZl/GDmFGk=;
        b=yMQm1j0VJNn39l7iUyXd5Fs79+bspvGQhqZyl3onvyF7uzdrZIna7j3xjDIRaBrxeD
         ni4MNyI/+7JeKg0JKQm1KcJgZgzPC73kyk5SvOj03N0DhiTAaE9QgGiGJ2QFYELbXNMn
         LSBlbB2w6IGkvCWSvbas6a2AJuY8353F4itF9GulIQSRTicvapg7c7gmTzrWosQwI52/
         ao0CEFjhxVI+zUAWiWsmlbXXq3QhKTOyP+ENlnLR4ANnF0N2PsRTL5Wc3dvBbfLUi0i7
         zjbrhZBmYRauKSN78S+MlcVEDr/NHzGWqKaeRShcaz6Lid4YaLXIWKvla3KftcduE8bG
         s9Pg==
X-Gm-Message-State: AOAM533Z43kTV4gLPork+NpfWmvZyFqjtFkK1NE4091BXk/gvzVGIQxm
        2anlQz0uhM5DkwYrQx8U0CPpxXqyOP36VbXzG5TrXkfeeLhcSSJb75+5oVWvximWeSRBU5sYkyI
        C7TpsjekLFY1ydaVarwWC6Q==
X-Received: by 2002:a9d:6a54:: with SMTP id h20mr1420695otn.69.1644936549411;
        Tue, 15 Feb 2022 06:49:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzai+xgP98JN0UjOQG8GF48r2lPVtIxEbdcn6aEWbM7Nij7yxY9X08kqNJaRqS2nI8+t+MGgw==
X-Received: by 2002:a9d:6a54:: with SMTP id h20mr1420684otn.69.1644936549204;
        Tue, 15 Feb 2022 06:49:09 -0800 (PST)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id v10sm13728219oto.53.2022.02.15.06.49.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 06:49:07 -0800 (PST)
Subject: Re: [PATCH v1 2/7] fpga: dfl: check feature type before parse irq
 info
To:     Tianfei zhang <tianfei.zhang@intel.com>, hao.wu@intel.com,
        mdf@kernel.org, yilun.xu@intel.com, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     corbet@lwn.net
References: <20220214112619.219761-1-tianfei.zhang@intel.com>
 <20220214112619.219761-3-tianfei.zhang@intel.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <0de9c8fb-0f04-684f-630c-1d13b0b55ba1@redhat.com>
Date:   Tue, 15 Feb 2022 06:49:05 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220214112619.219761-3-tianfei.zhang@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 2/14/22 3:26 AM, Tianfei zhang wrote:
> From: Tianfei Zhang <tianfei.zhang@intel.com>
>
> The feature ID of "Port User Interrupt" and the
> "PMCI Subsystem" are identical, 0x12, but one is for FME,
> other is for Port. It should check the feature type While
> parsing the irq info in parse_feature_irqs().

This seems like a bug fix and not part of iofs feature.

Split this out of the patchset.

This is a workaround a hardware problem, there should be some comments 
to the effect that you can't trust _this_ or _that_ feature id and some 
special handling earlier.

The ambiguity of feature id is a problem, and this sort of bug will 
happen again.

What can be done to prevent this in the future ?

>
> Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
> ---
>   drivers/fpga/dfl.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
>
> diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
> index 599bb21d86af..26f8cf890700 100644
> --- a/drivers/fpga/dfl.c
> +++ b/drivers/fpga/dfl.c
> @@ -940,9 +940,14 @@ static int parse_feature_irqs(struct build_feature_devs_info *binfo,
>   {
>   	void __iomem *base = binfo->ioaddr + ofst;
>   	unsigned int i, ibase, inr = 0;
> +	enum dfl_id_type type;
>   	int virq;
>   	u64 v;
>   
> +	type = feature_dev_id_type(binfo->feature_dev);
> +	if (type >= DFL_ID_MAX)
> +		return -EINVAL;
> +
>   	/*
>   	 * Ideally DFL framework should only read info from DFL header, but
>   	 * current version DFL only provides mmio resources information for
> @@ -959,16 +964,22 @@ static int parse_feature_irqs(struct build_feature_devs_info *binfo,
>   	 */
>   	switch (fid) {
>   	case PORT_FEATURE_ID_UINT:
> +		if (type != PORT_ID)
> +			break;

Instead of embedding a break in the switch, break the switch into fme 
switch and port switch

if (type == PORT_ID)

   port-switch

else if (type == FME_ID

   fme-switch

Tom

>   		v = readq(base + PORT_UINT_CAP);
>   		ibase = FIELD_GET(PORT_UINT_CAP_FST_VECT, v);
>   		inr = FIELD_GET(PORT_UINT_CAP_INT_NUM, v);
>   		break;
>   	case PORT_FEATURE_ID_ERROR:
> +		if (type != PORT_ID)
> +			break;
>   		v = readq(base + PORT_ERROR_CAP);
>   		ibase = FIELD_GET(PORT_ERROR_CAP_INT_VECT, v);
>   		inr = FIELD_GET(PORT_ERROR_CAP_SUPP_INT, v);
>   		break;
>   	case FME_FEATURE_ID_GLOBAL_ERR:
> +		if (type != FME_ID)
> +			break;
>   		v = readq(base + FME_ERROR_CAP);
>   		ibase = FIELD_GET(FME_ERROR_CAP_INT_VECT, v);
>   		inr = FIELD_GET(FME_ERROR_CAP_SUPP_INT, v);

