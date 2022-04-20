Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3457B507FD0
	for <lists+linux-fpga@lfdr.de>; Wed, 20 Apr 2022 06:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245369AbiDTEYg (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 20 Apr 2022 00:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbiDTEYf (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 20 Apr 2022 00:24:35 -0400
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1035512A9B;
        Tue, 19 Apr 2022 21:21:51 -0700 (PDT)
Received: by mail-pj1-f48.google.com with SMTP id e62-20020a17090a6fc400b001d2cd8e9b0aso819470pjk.5;
        Tue, 19 Apr 2022 21:21:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iTuAOAHUVJpjTZpyLgo06z+SkuCW6MaTC46oAl7CAV8=;
        b=KND7Kyl89AbTqodWvopHMSw3iqXJVmY+aB7O4m+Oc3lUMn9pNkQKSJaT+PTgPp/slu
         HKeDAlyhS0hVOf47dmrvS00+OFCe8CiWNcE4QwqjYdaMm0E6RMX1/T93zOv0WSYAORBr
         MaoeDtk/zor4pxQkXLAR2au82IiEPR8vkApldHZbjQWu6EyTAQlnj92qSHZ3oePLZVvf
         0nRmgLbzNtZjvu271eIsQYNHgmLkbVu94xi1YsmqPHGg/LOCNyzUH5MwAXqqtEZcEBga
         fM493yG5MCkNyIss0BCsIWoLcD0PrpFPrx0OtDT5oVTF2WLkZNjXX4Cknkn/2qMCSlR3
         uhjg==
X-Gm-Message-State: AOAM530R5k0jbwEGhTSPLC6C6y/czOxXgGuZ3hHwwfnD0gPT2/n3mVc9
        9RI5YGscOdOyBR7Uo3uGems=
X-Google-Smtp-Source: ABdhPJw7VNM6Dhl3/Pqg0G9eiYvHhyFDhwCVWdneoxzoozLi+Cjjm+bUmepyQouwZoTwWuQU+dyZfw==
X-Received: by 2002:a17:90b:4c84:b0:1d2:cadc:4e4d with SMTP id my4-20020a17090b4c8400b001d2cadc4e4dmr2237395pjb.8.1650428510408;
        Tue, 19 Apr 2022 21:21:50 -0700 (PDT)
Received: from localhost ([2601:647:5b00:ece1:6248:e226:d2e0:1f33])
        by smtp.gmail.com with ESMTPSA id w60-20020a17090a6bc200b001cbc1a6963asm18060666pjj.29.2022.04.19.21.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 21:21:49 -0700 (PDT)
Date:   Tue, 19 Apr 2022 21:21:47 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Moritz Fischer <mdf@kernel.org>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org, Xu Yilun <yilun.xu@intel.com>,
        Wu Hao <hao.wu@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] MAINTAINERS: Update linux-fpga repository location
Message-ID: <Yl+KW2BfkEYXeQz8@archbook>
References: <20220408022002.22957-1-mdf@kernel.org>
 <20220409154739.1a85472d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220409154739.1a85472d@canb.auug.org.au>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Sat, Apr 09, 2022 at 03:47:39PM +1000, Stephen Rothwell wrote:
> Hi Moritz,
> 
> On Thu,  7 Apr 2022 19:20:02 -0700 Moritz Fischer <mdf@kernel.org> wrote:
> >
> > As maintainer team we have decided to move the linux-fpga development
> > to a shared repository with shared access.
> > 
> > Cc: Xu Yilun <yilun.xu@intel.com>
> > Cc: Wu Hao <hao.wu@intel.com>
> > Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Moritz Fischer <mdf@kernel.org>
> > ---
> > 
> > Hi Stephen,
> > 
> > can you help us update the linux-next part accordingly?
> 
> I have done so, but you forgot to create the "fixes" branch in the new
> tree.  Also, did you want more contacts listed for the tree (apart from
> yourself)?

Fixed. Thanks!

If you could add Xu Yilun and Wu Hao as contacts that'd be great!

Sorry for the late reply. I was OOO.

- Moritz
