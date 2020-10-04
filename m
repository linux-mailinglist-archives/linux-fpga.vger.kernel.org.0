Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E661A282C7E
	for <lists+linux-fpga@lfdr.de>; Sun,  4 Oct 2020 20:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726085AbgJDSYS (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 4 Oct 2020 14:24:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33897 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726289AbgJDSYR (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 4 Oct 2020 14:24:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601835856;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E8ZxNpupxwPTV65+RP81g4lkpz2i0Y6pCQ1xRwIRNME=;
        b=IyXvCt1Ia0Ddun5PbFpaXmQLRWs/7yIFDwLxYspqb2p9Ar8+C7EXSnOyL6fADC2KcDRHTO
        f2gWx3Dx8E5NiuNZ3pAZKq+jzSidZjGJTi/5961kYWt3YMvXd5UkzNtVzgLFVPZDaIh6II
        IQY+RaAF7P3CIj2WEbaenWoLEypLQNg=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-593-oZeSPDUDPhWYWYaC9BlPsw-1; Sun, 04 Oct 2020 14:24:14 -0400
X-MC-Unique: oZeSPDUDPhWYWYaC9BlPsw-1
Received: by mail-qk1-f198.google.com with SMTP id c19so5090087qkk.20
        for <linux-fpga@vger.kernel.org>; Sun, 04 Oct 2020 11:24:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=E8ZxNpupxwPTV65+RP81g4lkpz2i0Y6pCQ1xRwIRNME=;
        b=bkGGaJtghtCFZ6KmE9QyTKckGSF7QVf6wSI0CwKiN9OQR0ybIA9I4nbK2mTpB8i59D
         ljjtFP8xn9iRcx4fxMaRFitNctayO/2vuS5O0rgRkrDIOLTWA5jmlg5pJUkNocPpMaEV
         Dz6JVXNqegDPq49H5euC5YuwQGyKTmMjzFW6tOEQ3PnJG4d0n1Yc3qC7kodL5sXrka6k
         Z1fq5SYG8lj7OI7a1j5xv/hvshPyKVNPSRqTJa9FAJdddNshAYjiK7+TO+P/hNPcefV7
         uiiObw6D7biSb1+2qMyqCYdE9+IYCmRKBXTcpe01RqKOU6oSbTPhN0m6qdmVw4NroV77
         23vw==
X-Gm-Message-State: AOAM531BJi6weyofP3VYeDJpYn5VVB42g02kmuUbyPHo/yt26HAUl9jo
        jqeIwBuvnUuokaBH8LOSuIq458QW+cV2pHX2esgG/4dEKbWn5UduDCFLZUNY2MkP+6zBFwKv+Np
        zcXiCU5A2XM9rplL4WVGgxQ==
X-Received: by 2002:a37:a09:: with SMTP id 9mr11595364qkk.258.1601835854183;
        Sun, 04 Oct 2020 11:24:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxD6FYIDoIjEuVUH1ue/9evG4iw0FY1m5Y5S3lDj8QlchqRq0P5tNL/UmpyyKi5RI1PY4dYNQ==
X-Received: by 2002:a37:a09:: with SMTP id 9mr11595349qkk.258.1601835853987;
        Sun, 04 Oct 2020 11:24:13 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id b191sm3008044qkg.81.2020.10.04.11.24.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Oct 2020 11:24:13 -0700 (PDT)
Subject: Re: [PATCH 04/10] fpga: fpga-mgr: ice40-spi: Simplify registration
To:     Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org
Cc:     hao.wu@intel.com, michal.simek@xilinx.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        russell.h.weight@intel.com, matthew.gerlach@intel.com
References: <20201004051423.75879-1-mdf@kernel.org>
 <20201004051423.75879-5-mdf@kernel.org>
From:   Tom Rix <trix@redhat.com>
Message-ID: <7db1517f-0244-ae4a-4a2d-78b3a9adf64a@redhat.com>
Date:   Sun, 4 Oct 2020 11:24:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201004051423.75879-5-mdf@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 10/3/20 10:14 PM, Moritz Fischer wrote:
> Simplify registration using new devm_fpga_mgr_register() API.
>
> Signed-off-by: Moritz Fischer <mdf@kernel.org>
> ---
>  drivers/fpga/ice40-spi.c | 14 +-------------
>  1 file changed, 1 insertion(+), 13 deletions(-)

LOTM

Reviewed-by: Tom Rix <trix@redhat.com>


