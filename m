Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAF4E26976F
	for <lists+linux-fpga@lfdr.de>; Mon, 14 Sep 2020 23:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725986AbgINVKd (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 14 Sep 2020 17:10:33 -0400
Received: from mail-pl1-f173.google.com ([209.85.214.173]:33849 "EHLO
        mail-pl1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbgINVKa (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 14 Sep 2020 17:10:30 -0400
Received: by mail-pl1-f173.google.com with SMTP id r19so132081pls.1
        for <linux-fpga@vger.kernel.org>; Mon, 14 Sep 2020 14:10:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FqW8mnWC5Wn+fLRENpU7f7VS4Hy+CapicUsqeX7D5Nw=;
        b=Id7N8zlN9cSxLGqD3P5F3TblIbFcOfulo80HFHPZs/d/gbOTjs9hRPBnbx5iaB20H5
         ADxgxOu6wvh4b81aX5Wq8vio2g0YiWyDoRK9hF4MVZpse+NgriSM6dCLAkJyYHFe6Znq
         1Tp4lhEzFBk5l15Ic82voxuQ4xeHXv8EaTDxP+9F039fM5qz43H1m9PwdAQbuEp3gOf1
         hLXnuhq5GTGx78w5ZF2F8npa+vdTHjYvDCqHF75JyxWduye1363AUD96H8ir3iHPsHt1
         s0NYPyBnvmPMtda5FWV21iPvIVCjKLkCyXG3fD0xyJK3Z3m5WLC02a8O3JL7zTDHeMmz
         dlRA==
X-Gm-Message-State: AOAM531Tuvh7FQ54o0p0mGjjY7nxmPDpupczchnrMJBSI42tD+inoDBL
        tgJiqZ2KGTRym2PFyba6DJs=
X-Google-Smtp-Source: ABdhPJwkVLZ6k1LfH09ZEQvthzcJJDkfP5o5Y7CGz3fgwgEegOQXVkkmTcrySkFDKfC7pVzzrdGcYw==
X-Received: by 2002:a17:90b:1915:: with SMTP id mp21mr1054664pjb.116.1600117828961;
        Mon, 14 Sep 2020 14:10:28 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1162:1ac0:17a6:4cc6:d1ef])
        by smtp.gmail.com with ESMTPSA id k24sm11293485pfg.148.2020.09.14.14.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 14:10:28 -0700 (PDT)
Date:   Mon, 14 Sep 2020 14:10:12 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Tom Rix <trix@redhat.com>
Cc:     "mdf@kernel.org" <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>
Subject: Re: RFC improving amount of content in 5.11
Message-ID: <20200914211012.GA22855@archbook>
References: <3295710c-5e82-7b97-43de-99b9870a8c8c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3295710c-5e82-7b97-43de-99b9870a8c8c@redhat.com>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Tom,

On Mon, Sep 14, 2020 at 01:29:47PM -0700, Tom Rix wrote:
> I am disappointed with how little content is making it into 5.10

One comment I've gotten from Greg in the past is to not hold on to
patches so long, so the pull request this weekend was me trying to a
first set of changes out there. This doesn't mean it has to be the only
content that goes into 5.10 (Note how the pull request said: "First set
of changes for the 5.10 merge window").

> So I was wondering what we can do generally and i can do specifically
> to improve this.
> 
> My comment
> Though we are a low volume list, anything non trivial takes about 8 revisions.
> My suggestion is that we all try to give the developer our big first
> pass review within a week of the patch landing and try to cut the
> revisions down to 3.

It's unfortunate that it takes so long to get things moving, I agree,
but with everything that's going on - bear in mind people deal different
with situations like the present - it is what it is.

My current dayjob doesn't pay me for working on this so the time I dedicate
to this comes out of my spare time and weekends - Personally I'd rather
not burn out and keep functioning in the long run.

Thanks,
Moritz
