Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C37A52F20CB
	for <lists+linux-fpga@lfdr.de>; Mon, 11 Jan 2021 21:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731948AbhAKU3Z (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 11 Jan 2021 15:29:25 -0500
Received: from mail-pj1-f46.google.com ([209.85.216.46]:37355 "EHLO
        mail-pj1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730029AbhAKU3Y (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 11 Jan 2021 15:29:24 -0500
Received: by mail-pj1-f46.google.com with SMTP id b5so248360pjk.2;
        Mon, 11 Jan 2021 12:29:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=bs5hIiTdtArUwZXVNhTrx+cKzcudFaDql1aXMWa105w=;
        b=OjVhuO0DNwFguyoS/oxCHqSinv+bNI72Axq94w0aMt3aiAegtb/HZTQYNKqqbvFl4E
         kSUb9RFY8TrmvthCFMOldtI5zIHi/vx8sfIFfvap7Nu/WoENtdEZFscnpiEKpHLGlyG0
         kV2ubmAmi6DMqggs0Fn9j7zLWJySCelZeTo2r0aekL8LTUpkglm3rAAdIOrK0qpx8bmq
         FBhgm+I4OzCZlw+HyTwLQVj1zXj6JlxKNMq02qYdcmfhJwgqlpv9TVwcvC/OtSFhiNDt
         7w1qOhzp4kWS+tbq02VimhrxisxKtrGrxedxp7+neGMBSNO1esjVPCr9Q2AKQQMZrjZm
         bX3A==
X-Gm-Message-State: AOAM531R6JlT0wRk4ldFj2eNLJRaxznICagqHFjezY8NNStB19WlHt3L
        VzL7gqrM0N8Ek8kmWC3CSlg=
X-Google-Smtp-Source: ABdhPJz8Gygell2OGxA9tak/DOtNQ8K+ZDbfPgkSyJjxKxsTs8Pk33MM+LjV/R3qj5esOjH4Z48v5Q==
X-Received: by 2002:a17:902:a501:b029:dc:3e1d:4ddb with SMTP id s1-20020a170902a501b02900dc3e1d4ddbmr1073418plq.60.1610396923727;
        Mon, 11 Jan 2021 12:28:43 -0800 (PST)
Received: from localhost ([2601:647:5b00:1162:1ac0:17a6:4cc6:d1ef])
        by smtp.gmail.com with ESMTPSA id b5sm626768pga.54.2021.01.11.12.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 12:28:42 -0800 (PST)
Date:   Mon, 11 Jan 2021 12:28:41 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     Tom Rix <trix@redhat.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Moritz Fischer <mdf@kernel.org>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        linux-kernel@vger.kernel.org, moritzf@google.com,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Zheng Yongjun <zhengyongjun3@huawei.com>,
        Russ Weight <russell.h.weight@intel.com>,
        "Gerlach, Matthew" <matthew.gerlach@intel.com>,
        Sonal Santan <sonal.santan@xilinx.com>,
        Xu Yilun <yilun.xu@intel.com>,
        Richard Gong <richard.gong@intel.com>
Subject: Re: [PATCH 0/8] FPGA DFL Changes for 5.12
Message-ID: <X/y0+ZCPsfrg/LUp@archbook>
References: <X/sz6lDq8WFzrRUJ@archbook>
 <95af46d6-d123-f610-2f21-6d6de6f248e9@redhat.com>
 <X/v2xs5Rnfw9F18E@kroah.com>
 <9bc01a73-726f-a979-1246-6ea048961670@redhat.com>
 <X/xmi/jJmDHnV5/N@kroah.com>
 <7923d9dc-c503-5318-6e4f-931f8c13c1be@redhat.com>
 <X/x4QjGyP8ssYUDI@kroah.com>
 <fe9739cf-abc9-c0c6-933e-8447a9d197a8@redhat.com>
 <X/yXOFYnQcA1MsUd@kroah.com>
 <dccc8075-b900-8680-3620-8050475858a7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dccc8075-b900-8680-3620-8050475858a7@redhat.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Tom,

On Mon, Jan 11, 2021 at 11:46:03AM -0800, Tom Rix wrote:

[..]
> I have been doing the first review in a couple of days after every patch landing.

I appreciate your help with doing reviews.
 
> I see some pretty good response from the developers to fix the issues raised. 

... yet patches have been rejected. So it doesn't seem purely a matter
of throughput?

> But I do not see Moritz picking up the review until weeks later.

I'll admit there are delays that happen, I have a dayjob as I pointed
out in earlier conversations. Furthermore, just because I do not
immediately send out an email does not mean I don't look at stuff.

If people show up with 100kLOC patchsets that don't pass checkpatch,
it'll take a while for me to even read up and understand what they're
doing / trying to do.

> This consistent delay in timely reviews is a bottleneck.

As Greg pointed out even ones that were reviewed got rejected, so
clearly the issue is with the quality and not the speed at which we send
them on.

> It would be good if the big first reviews could be done in parallel.

Again depending how the patchsets are structured it will take me a while
to process. Having them re-use existing infrastructure, following
coding and submission guidelines will speed up the process.

On a personal level, being told I'm too slow and not doing my job as
maintainer doesn't exactly increase my motivation to get to it ...

- Moritz
