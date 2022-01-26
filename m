Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBA7B49C2D8
	for <lists+linux-fpga@lfdr.de>; Wed, 26 Jan 2022 05:56:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbiAZEyv (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 25 Jan 2022 23:54:51 -0500
Received: from mail-pf1-f180.google.com ([209.85.210.180]:43765 "EHLO
        mail-pf1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiAZEyv (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 25 Jan 2022 23:54:51 -0500
Received: by mail-pf1-f180.google.com with SMTP id d187so373230pfa.10
        for <linux-fpga@vger.kernel.org>; Tue, 25 Jan 2022 20:54:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8Z0rG09400uyWMaIJNwzX0xjcR3pl4S9ZR/Ccmb2Xgk=;
        b=Se1nuTtDQ6C/+HvmvVGd1VbMdJFQCIyKL2zaokZSL2O0FVEmDEx8ALoaVqe0RjhdXb
         oWk4+E5Y3SFwcnMXApTdpxtGYMxzB6wzT67U4mcMRRshvwuffHdyegoTdeUzP0IRAd6v
         BY85tswU03fYVyeEdQS03o1Kk1SYg30+UOEriXXshRwbrqi7sW2OhmSRLN6NTmiqOkXG
         hT/wttWBWOIqxwon9wKZwPyzeyZg8oFv9H4DWTvOf+EzevmymMfyvGg+Xm/FjoxlAt3Q
         ChQetpBz3TLxoESTTSB0M5YeXpqC3OhIMPLL+eeyo3c1JnX5kZjILu5aQxSxVd+2XRMT
         IiWw==
X-Gm-Message-State: AOAM532h1fJmXGDqn0m4ASVX5TD0l3CPV908JhmTu3wU1javbVKVOFbo
        3V5w66yK1ZnA8Zhv0UcXdq4ChZCFpvE=
X-Google-Smtp-Source: ABdhPJzACQM0dlm2VNEKFOMJNdER3sD3vJPrBDABxIvpLio5wNegzfOCT5/7WmlBcZbiYtmq8CKEtA==
X-Received: by 2002:a63:4e24:: with SMTP id c36mr17328998pgb.499.1643172890480;
        Tue, 25 Jan 2022 20:54:50 -0800 (PST)
Received: from localhost ([2601:647:5b00:ece0:aab:34ff:52ca:a7a5])
        by smtp.gmail.com with ESMTPSA id x187sm4849425pgx.10.2022.01.25.20.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 20:54:49 -0800 (PST)
Date:   Tue, 25 Jan 2022 20:54:48 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     Xu Yilun <yilun.xu@intel.com>, mdf@kernel.org, hao.wu@intel.com,
        trix@redhat.com, linux-fpga@vger.kernel.org,
        Richard Gong <richard.gong@intel.com>
Subject: Re: [PATCH] firmware: stratix10-svc: extend SVC driver to get the
 firmware version
Message-ID: <YfDUGD5+hqOnSNjP@epycbox.lan>
References: <20220125192853.1956486-1-dinguyen@kernel.org>
 <20220126010723.GA1139334@yilunxu-OptiPlex-7050>
 <5a1b6658-062c-d777-69d3-6a053d087ca6@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a1b6658-062c-d777-69d3-6a053d087ca6@kernel.org>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Dinh,

On Tue, Jan 25, 2022 at 10:31:06PM -0600, Dinh Nguyen wrote:
> 
> 
> On 1/25/22 19:07, Xu Yilun wrote:
> > On Tue, Jan 25, 2022 at 01:28:53PM -0600, Dinh Nguyen wrote:
> > > From: Richard Gong <richard.gong@intel.com>
> > > 
> > > Extend Intel service layer driver to get the firmware version running at
> > > FPGA device. Therefore FPGA manager driver, one of Intel service layer
> > > driver's client, can decide whether to handle the newly added bitstream
> > > authentication function based on the retrieved firmware version.
> > > 
> > > Acked-by: Moritz Fischr <mdf@kernel.org>
> > 
> > This is already acked and no more change, is it? So please just ping in
> > the original mail or add the [RESEND PATCH] prefix.
> > 
> > The patch is good to me.
> > 
> > Acked-by: Xu Yilun <yilun.xu@intel.com>
> > 
> 
> Thanks, I added Moritz Acked-by: is the only change.
> 
> Dinh

Did we traditionally take those through FPGA tree, did Greg pick those
up?

Cheers,
Moritz
