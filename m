Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A300B50803C
	for <lists+linux-fpga@lfdr.de>; Wed, 20 Apr 2022 06:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237652AbiDTEl7 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 20 Apr 2022 00:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238756AbiDTEl7 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 20 Apr 2022 00:41:59 -0400
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599F21ADB5;
        Tue, 19 Apr 2022 21:39:13 -0700 (PDT)
Received: by mail-pg1-f172.google.com with SMTP id i63so490891pge.11;
        Tue, 19 Apr 2022 21:39:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2JsgksxBmW3C0KtmBACunzaIxIyyKQN73OZ8PGC7CI0=;
        b=DYWZd9egguL13C6NenMnY0CBYiTRofXjsCHJrPgwp7fUgp41oLRjZfknGRmuzHltZM
         EpuhXDPc6AeGPQPKH1XPgYY38LDRKAkSkG379m8iUWxLDpPpT6EedywaDnnohLP68nbh
         04zYmMuFWtS0R5tmy0rEtj0mTqExH/ow9QUBlFDD7eNDW7snqr+s4dAwHeBxeFvl3KNi
         RpsOBs0KaPEaaGwwPgZDNnBdKN4Z14Jyb7XSp9m14lB5bzDGjtrD8en4f1llT1WaBTrL
         CLEuzXdTO2Z+xUK/pm5thoAyXDT8L2jyGvUl6E9tGioq0Z+i3FR22Wfq7AUyy93bCc4V
         4DlA==
X-Gm-Message-State: AOAM532YXAGhmeg/MKglnxALTQFMQtgYB8DyOGTSByf2X8J3/jDIfN80
        kMSas52hPDDrkuof9NsaC2c=
X-Google-Smtp-Source: ABdhPJxJ75A/PZwi3oy/W68TETY0jb9b7vhAuLwskty9YeVIJUcdkqP6cwoiAMZPYZ3wOslujWZ3ww==
X-Received: by 2002:a65:4203:0:b0:39d:6f6c:6b62 with SMTP id c3-20020a654203000000b0039d6f6c6b62mr17331592pgq.78.1650429552819;
        Tue, 19 Apr 2022 21:39:12 -0700 (PDT)
Received: from localhost ([2601:647:5b00:ece1:6248:e226:d2e0:1f33])
        by smtp.gmail.com with ESMTPSA id br10-20020a056a00440a00b0050a777cd10csm8984265pfb.91.2022.04.19.21.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 21:39:11 -0700 (PDT)
Date:   Tue, 19 Apr 2022 21:39:10 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Moritz Fischer <mdf@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
        Xu Yilun <yilun.xu@intel.com>, Wu Hao <hao.wu@intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] MAINTAINERS: Update linux-fpga repository location
Message-ID: <Yl+ObpM2d2wuJfkY@archbook>
References: <20220408022002.22957-1-mdf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220408022002.22957-1-mdf@kernel.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, Apr 07, 2022 at 07:20:02PM -0700, Moritz Fischer wrote:
> As maintainer team we have decided to move the linux-fpga development
> to a shared repository with shared access.
> 
> Cc: Xu Yilun <yilun.xu@intel.com>
> Cc: Wu Hao <hao.wu@intel.com>
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Moritz Fischer <mdf@kernel.org>
> ---
> 
> Hi Stephen,
> 
> can you help us update the linux-next part accordingly?
> 
> Thanks,
> 
> Moritz
> ---
> 
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fd768d43e048..9b08d5ea001e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7717,7 +7717,7 @@ R:	Tom Rix <trix@redhat.com>
>  L:	linux-fpga@vger.kernel.org
>  S:	Maintained
>  Q:	http://patchwork.kernel.org/project/linux-fpga/list/
> -T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mdf/linux-fpga.git
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/fpga/linux-fpga.git
>  F:	Documentation/devicetree/bindings/fpga/
>  F:	Documentation/driver-api/fpga/
>  F:	Documentation/fpga/
> -- 
> 2.35.1
> 

Applied to for-next,

- Moritz
