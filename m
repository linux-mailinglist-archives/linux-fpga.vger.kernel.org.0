Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 152CA3AD4C4
	for <lists+linux-fpga@lfdr.de>; Sat, 19 Jun 2021 00:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234795AbhFRWGO (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 18 Jun 2021 18:06:14 -0400
Received: from mail-pf1-f175.google.com ([209.85.210.175]:37438 "EHLO
        mail-pf1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234644AbhFRWGO (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 18 Jun 2021 18:06:14 -0400
Received: by mail-pf1-f175.google.com with SMTP id y15so2956792pfl.4;
        Fri, 18 Jun 2021 15:04:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hkNP585a5xlPYA20Og1iRNDEjU13UUBC0QX07bSQG+s=;
        b=r4SLARvkCxcw8/g6Z2mI4kH3FNlxfefR0sAQ8V5mPARALH+6ES3EQRrV5F0eD94nrT
         ofaTa/VbvNCzTiA7C1iLIrtkeoU55T1/6+/UbqIiCDOmSUvv9ZuLOlB2XdrMhPECJqJP
         RjtiYYvrN7G0U25pcXe1VjC0MtCzwEOvD40O9Dj17TFefWZc+SrmkcWfghxucqUA/9K5
         fiwKFGxVUGExjPgcof9J47lLS6lqvEVSv7K1SYsY6jP8DLlBOpzZsf5qD2PgAsfHipFQ
         Z7itI7Pa3CrvBejy/GrLLA1z3xUK7/mov2CvUdG9P1IiKh/LPHODjngqf+D2XJARPaYt
         rBnA==
X-Gm-Message-State: AOAM531XQbJZyVlpp9S9ufZrUjk2E3PHmx4ofIFBbPOh4wYT/nCjA2pV
        CiXEB6eva5Y8cwTkdirwEQw=
X-Google-Smtp-Source: ABdhPJzP1/CYXUpkZlMjnJtsfsGgosInFZf1i7QV+y/ubdfaYFr/rY9jqUPioDdJJxxhYuvVp5b7uA==
X-Received: by 2002:a63:f749:: with SMTP id f9mr11882425pgk.369.1624053843230;
        Fri, 18 Jun 2021 15:04:03 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id d127sm8721779pfc.50.2021.06.18.15.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 15:04:02 -0700 (PDT)
Date:   Fri, 18 Jun 2021 15:04:01 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Tom Rix <trix@redhat.com>
Cc:     "Wu, Hao" <hao.wu@intel.com>, Moritz Fischer <mdf@kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "krzysztof.kozlowski@canonical.com" 
        <krzysztof.kozlowski@canonical.com>,
        "nava.manne@xilinx.com" <nava.manne@xilinx.com>,
        "Xu, Yilun" <yilun.xu@intel.com>,
        "davidgow@google.com" <davidgow@google.com>,
        "fpacheco@redhat.com" <fpacheco@redhat.com>,
        "Gong, Richard" <richard.gong@intel.com>,
        "luca@lucaceresoli.net" <luca@lucaceresoli.net>,
        "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v4 1/4] fpga: dfl: reorganize to subdir layout
Message-ID: <YM0YUboHxgzWvtgY@epycbox.lan>
References: <20210614201648.3358206-1-trix@redhat.com>
 <20210614201648.3358206-3-trix@redhat.com>
 <DM6PR11MB381964374223D0D2958AFA6985309@DM6PR11MB3819.namprd11.prod.outlook.com>
 <d64b0fb8-5f83-2995-7ee9-b4ed2932ef60@redhat.com>
 <DM6PR11MB3819259241791EB04A2CB9C8850F9@DM6PR11MB3819.namprd11.prod.outlook.com>
 <YMrS9OUSaCdtGwrE@epycbox.lan>
 <DM6PR11MB381924F43550A6699CB55213850E9@DM6PR11MB3819.namprd11.prod.outlook.com>
 <9c527087-3646-2f22-1234-2b0247511cc9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c527087-3646-2f22-1234-2b0247511cc9@redhat.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, Jun 17, 2021 at 06:21:07AM -0700, Tom Rix wrote:

> xrt is bringing in the subdir xrt/

That alone I don't mind too much.
 
> Even after the likely move of xrt subdevices to other subsystems, there will
> be about as many files in fpga/xrt/ as in fpga/
> 
> If both of you are fine with a mixed files and subdir organization, then
> I'll drop this patchset.

You've done most of the work for this already, so we might as well
finish what you started :)

Thanks,
Moritz
