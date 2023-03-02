Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 868286A82D1
	for <lists+linux-fpga@lfdr.de>; Thu,  2 Mar 2023 13:54:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbjCBMwg (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 2 Mar 2023 07:52:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjCBMwf (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 2 Mar 2023 07:52:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA2C4A1C9
        for <linux-fpga@vger.kernel.org>; Thu,  2 Mar 2023 04:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677761507;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DR5YVBr/x9+aRDb+r/vDhczxRjgIEO+n2mwtVeMKmG8=;
        b=N8megm/CmEd26xjc91o9RUR+xyTZFQHazhFUZuQDRi8AlQWPdMSDgCflSaVCLrPCc9IWx3
        dh9MfkkQJcTZJf6SwrGhe4nNlCvBxyAEzdEAQeS3AdHL1OlKfGvXHjchHTtTMrNODu+LQW
        9N0agdUDErLdMSeAwIrcXRMb70HsVMc=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-484-ytJhJDlFPCqzDUKvdHM7EQ-1; Thu, 02 Mar 2023 07:51:46 -0500
X-MC-Unique: ytJhJDlFPCqzDUKvdHM7EQ-1
Received: by mail-qt1-f198.google.com with SMTP id h21-20020ac87d55000000b003bffb1c9745so2273760qtb.4
        for <linux-fpga@vger.kernel.org>; Thu, 02 Mar 2023 04:51:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677761506;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DR5YVBr/x9+aRDb+r/vDhczxRjgIEO+n2mwtVeMKmG8=;
        b=NzK7tLS3NyeZNJ6Lb3RPjMDdlwZKAKbuXKhcK6uALn3ztFtPkxLJ/tMTxuEGVJXaLL
         iYxOB/jWrogSjnBBboSyQesX6l/l3ErnPzEGAY7X/HGB9WyzFlM4Z7jy5E1rCX3PTMlV
         nZ6vxhmYN6c/F6C8Yglc6wgCxoUXf2BeUojqpnlUQ7dF8loha5KWA3sseCM4yYorJXdQ
         p8moiPY+vxLpLBpGzej9/qZDBGFxZJvh3LlVp1wmurzEKCg7091VJc2lOQ0o1T0EbvBw
         SF3wAQBjG79XtRDQnz+S1zR0ia5AODPGPdWm/dsJfMoPanTmk5QwqZtFJAqpuNXYoZ+h
         DP5w==
X-Gm-Message-State: AO0yUKUiBZ7MD7KTQVzjZg3Lr79kBy9qU37WbkcDmbMSYRw3HvnNHtrz
        cwodazGHSbgc/TCXCPxkcXmFkvi3WQdHst55dKleyOu07UKQnHXDZjNYoOvoy6HHdZ7LqbMCcms
        4011H3ZXQmwqVRcbEZQoPEg==
X-Received: by 2002:ad4:5e8c:0:b0:572:80ea:5fc7 with SMTP id jl12-20020ad45e8c000000b0057280ea5fc7mr19389433qvb.41.1677761506191;
        Thu, 02 Mar 2023 04:51:46 -0800 (PST)
X-Google-Smtp-Source: AK7set9jsnwyD2Sf7KyvM/J+R6gYA0DW2pRs4wFZmAJ5y3M16fMFvjRvODuFjV0jWoPb+A/GngRNHg==
X-Received: by 2002:ad4:5e8c:0:b0:572:80ea:5fc7 with SMTP id jl12-20020ad45e8c000000b0057280ea5fc7mr19389412qvb.41.1677761505946;
        Thu, 02 Mar 2023 04:51:45 -0800 (PST)
Received: from [192.168.1.19] (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id 1-20020a370701000000b007426f115a4esm10776260qkh.129.2023.03.02.04.51.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Mar 2023 04:51:45 -0800 (PST)
Subject: Re: [PATCH] fpga: bridge: fix kernel-doc parameter description
To:     Marco Pagani <marpagan@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Tull <atull@kernel.org>
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230301140309.512578-1-marpagan@redhat.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <4e15feab-5d75-6748-324d-ff58d0f862b8@redhat.com>
Date:   Thu, 2 Mar 2023 04:51:43 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20230301140309.512578-1-marpagan@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 3/1/23 6:03 AM, Marco Pagani wrote:
> Fix the kernel-doc description for the "struct fpga_image_info *info"
> parameter of the fpga_bridge_get() function.
>
> Fixes: 060ac5c8fa7b ("fpga: bridge: kernel-doc fixes")
> Signed-off-by: Marco Pagani <marpagan@redhat.com>
Reviewed-by: Tom Rix <trix@redhat.com>
> ---
>   drivers/fpga/fpga-bridge.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
> index 5cd40acab5bf..ff4470067ed5 100644
> --- a/drivers/fpga/fpga-bridge.c
> +++ b/drivers/fpga/fpga-bridge.c
> @@ -115,7 +115,7 @@ static int fpga_bridge_dev_match(struct device *dev, const void *data)
>   /**
>    * fpga_bridge_get - get an exclusive reference to an fpga bridge
>    * @dev:	parent device that fpga bridge was registered with
> - * @info:	fpga manager info
> + * @info:	fpga image specific information
>    *
>    * Given a device, get an exclusive reference to an fpga bridge.
>    *

