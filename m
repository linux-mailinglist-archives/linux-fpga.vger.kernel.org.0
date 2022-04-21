Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9F650A33E
	for <lists+linux-fpga@lfdr.de>; Thu, 21 Apr 2022 16:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389630AbiDUOuL (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 21 Apr 2022 10:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389629AbiDUOuK (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 21 Apr 2022 10:50:10 -0400
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A8842A32;
        Thu, 21 Apr 2022 07:47:20 -0700 (PDT)
Received: by mail-pl1-f180.google.com with SMTP id t12so5077824pll.7;
        Thu, 21 Apr 2022 07:47:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=g202DJgphpepUMd7JLCHKLgUnPLzuZXeZkNUO2SATTw=;
        b=3bhRDFwtKMS4adOqMnmfloduEPDa8Pmbs7wQgecRj8a4qi92NUzm07yU87FstKQkNm
         uVy9ScoJvw4crowbmGUl1TPoTnpbUI6uT4ML+zK/iFiURfHaVJe+PGMvnIVjcT3wBnHg
         i3pFmxWl1w+1n2I1TxOVKC2L0lwVueTRgZHX3TB5zVjR14ImSSTpwEWhTOTXMCm1HGqk
         dO/XIH1gpLeQqI6lX3XhNVPiU6Glz6k5aQqfIt+5UyHEcsfZxOVAiZyPVaTmMnLvU461
         Mp7h3l9FZ7Maj+oXRc7Vz9azeQaXgLajxjPJk/apsgh39ag66pqN8RnRhrnwg7YWWO12
         qBeQ==
X-Gm-Message-State: AOAM532KhwuB27+iHD2NqnZ5/ONJIzyCH1AdyAnX/5fqVhlTC12cai4T
        A082NZ57gwnlFhDby3GtGOQ=
X-Google-Smtp-Source: ABdhPJwBBG1+ZOyO338IDd1IlfZfSzpt6gLj8EEu9VjP4CL3AXLKJFs5PAwxfQV9lBn2EFmUoYRH2w==
X-Received: by 2002:a17:903:31c8:b0:158:d060:eab7 with SMTP id v8-20020a17090331c800b00158d060eab7mr25810957ple.5.1650552439960;
        Thu, 21 Apr 2022 07:47:19 -0700 (PDT)
Received: from localhost ([2601:647:5b00:ece1:6248:e226:d2e0:1f33])
        by smtp.gmail.com with ESMTPSA id c2-20020a63a442000000b0039cc5a6af1csm22577214pgp.30.2022.04.21.07.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 07:47:19 -0700 (PDT)
Date:   Thu, 21 Apr 2022 07:47:18 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Tianfei Zhang <tianfei.zhang@intel.com>
Cc:     hao.wu@intel.com, trix@redhat.com, mdf@kernel.org,
        yilun.xu@intel.com, linux-fpga@vger.kernel.org,
        linux-doc@vger.kernel.org, corbet@lwn.net,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>
Subject: Re: [PATCH v7 2/2] Documentation: fpga: dfl: add link address of
 feature id table
Message-ID: <YmFudmiIRh5RHGQ+@archbook>
References: <20220419032942.427429-1-tianfei.zhang@intel.com>
 <20220419032942.427429-3-tianfei.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220419032942.427429-3-tianfei.zhang@intel.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, Apr 18, 2022 at 11:29:42PM -0400, Tianfei Zhang wrote:
> From: Tianfei zhang <tianfei.zhang@intel.com>
> 
> This patch adds the link address of feature id table in documentation.
> 
> Reviewed-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Signed-off-by: Tianfei zhang <tianfei.zhang@intel.com>
Acked-by: Moritz Fischer <mdf@kernel.org>
> ---
> v7:
>   - change the title and git commit message.
>   - add Reviewed by from Matthew Gerlach.
> v6: fix documentation from Hao's comment.
> v5: fix documentation from Matthew's comment.
> ---
>  Documentation/fpga/dfl.rst | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
> index ef9eec71f6f3..15b670926084 100644
> --- a/Documentation/fpga/dfl.rst
> +++ b/Documentation/fpga/dfl.rst
> @@ -502,6 +502,11 @@ Developer only needs to provide a sub feature driver with matched feature id.
>  FME Partial Reconfiguration Sub Feature driver (see drivers/fpga/dfl-fme-pr.c)
>  could be a reference.
>  
> +Please refer to below link to existing feature id table and guide for new feature
> +ids application.
> +https://github.com/OPAE/dfl-feature-id
> +
> +
>  Location of DFLs on a PCI Device
>  ================================
>  The original method for finding a DFL on a PCI device assumed the start of the
> -- 
> 2.26.2
> 
