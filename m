Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91CBF583EE6
	for <lists+linux-fpga@lfdr.de>; Thu, 28 Jul 2022 14:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237606AbiG1M34 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 28 Jul 2022 08:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237296AbiG1M3z (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 28 Jul 2022 08:29:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A45DA67CAE
        for <linux-fpga@vger.kernel.org>; Thu, 28 Jul 2022 05:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659011393;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DVcjc9aGp+5z1mxJ4Ml6zvFn8nDWG68bHV4wWJvB5yk=;
        b=MswelC7M4GcWI/rqW5n3b9dIRIqJVwdEwopXoKHcKyfY5+LAdZ6Z84YQAgAErQnZLgMGvP
        Y0Rx3fcMz0nODP+5Btyvhl13JK/ZilFuP7oSVc5I8D+Oz5JV91qLiZDVHo2DRd81QTjrGV
        N3PRWLk9xbaZohNZn3M3v6hmq4rYW1I=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-284-3m28XXg5NRW3imgUpXhmCA-1; Thu, 28 Jul 2022 08:29:52 -0400
X-MC-Unique: 3m28XXg5NRW3imgUpXhmCA-1
Received: by mail-oo1-f69.google.com with SMTP id n5-20020a4ab345000000b0040e5ffbd237so608496ooo.15
        for <linux-fpga@vger.kernel.org>; Thu, 28 Jul 2022 05:29:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=DVcjc9aGp+5z1mxJ4Ml6zvFn8nDWG68bHV4wWJvB5yk=;
        b=zSLJoM4ayi1PMnXN3CgtfA/O9JBPCYutGMQ0K5qOk3NNOhCY7sn32JPfZItH9hHSnJ
         6nt16aGSjMFkn1iC8Tqzk4ME/mOnpo8ZzICFdQ7cs/1gqplw03YfrTMWViaCa/H2PWIo
         KwPoNJMAH31c3Oujmd4cDfXyvp3dg3Scq7kY+ABOQbus7fcXSguJzfdLitrI1HP6Abpe
         q0u/0whMyZbvZ9Ksk1ozcLYL8vV7xY+bgUTGRXdPLXvKwvsApRfgq3bc6eOa75quoYjv
         ep8UiRmOv3QRd7GsAEIc3NlPvCm3ES+U8HuvX4PtVKxquco3tX/J4HN4up71wTKoSybm
         ggqA==
X-Gm-Message-State: AJIora/zZwydtGHX2hlrqTSR/sgndi8zAg3ReUJLnZJrTeqZbOAgGXM2
        kBLKJ7DAVPi+ciGPjnf/jUUGmbbKOkOszw6ddsCJS+PNm/COrBvbejFgkrOMA55/HNTAHkY5f6b
        XSzux+feLHxVGxPe4X4WGTw==
X-Received: by 2002:a4a:a981:0:b0:435:bd5a:7e5f with SMTP id w1-20020a4aa981000000b00435bd5a7e5fmr9218543oom.76.1659011391871;
        Thu, 28 Jul 2022 05:29:51 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uFGMuinIsJqCT9rk8zdxkHpWjdWvhZVScblBpoUcod9Lk+uEhgVp6FLm1lfVIiviIN1kkv9w==
X-Received: by 2002:a4a:a981:0:b0:435:bd5a:7e5f with SMTP id w1-20020a4aa981000000b00435bd5a7e5fmr9218527oom.76.1659011391465;
        Thu, 28 Jul 2022 05:29:51 -0700 (PDT)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id c5-20020a056830000500b00616c46f6daasm226415otp.31.2022.07.28.05.29.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jul 2022 05:29:50 -0700 (PDT)
Subject: Re: [PATCH] fpga: microchip-spi: add missing module author entry
To:     Conor Dooley <conor.dooley@microchip.com>,
        Ivan Bornyakov <i.bornyakov@metrotek.ru>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220728075012.3136914-1-conor.dooley@microchip.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <53f6e675-1fc5-fb17-ce6f-aa952d61132f@redhat.com>
Date:   Thu, 28 Jul 2022 05:29:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220728075012.3136914-1-conor.dooley@microchip.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 7/28/22 12:50 AM, Conor Dooley wrote:
> Add the missing MODULE_AUTHOR entry for the Microchip spi-slave FPGA
> programming driver.
>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Tom Rix <trix@redhat.com>
> ---
>   drivers/fpga/microchip-spi.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/fpga/microchip-spi.c b/drivers/fpga/microchip-spi.c
> index bd284c7b8dc9..7436976ea904 100644
> --- a/drivers/fpga/microchip-spi.c
> +++ b/drivers/fpga/microchip-spi.c
> @@ -395,4 +395,5 @@ static struct spi_driver mpf_driver = {
>   module_spi_driver(mpf_driver);
>   
>   MODULE_DESCRIPTION("Microchip Polarfire SPI FPGA Manager");
> +MODULE_AUTHOR("Ivan Bornyakov <i.bornyakov@metrotek.ru>");
>   MODULE_LICENSE("GPL");

