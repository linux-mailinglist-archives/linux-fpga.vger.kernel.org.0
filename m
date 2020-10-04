Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB3E282C8E
	for <lists+linux-fpga@lfdr.de>; Sun,  4 Oct 2020 20:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbgJDSdt (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 4 Oct 2020 14:33:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34167 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726085AbgJDSdt (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 4 Oct 2020 14:33:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601836428;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wt9msYI7XrCVAscXBqWyRdDyyGcbJ8JffuRgtP6fprM=;
        b=SVazhf9qIu8VNgH+572q7K3l9U4pWc5DfLtF5g2M/IcIHHqzW7rD+3QdYUzsJOpGYfWvBV
        ywDWYCNlUtQpKYemvL3J+AQj1bYVEHOoJikhKd+Dhc7Vupt+mCMdzl/mLEptqLCJ+oen84
        Ra0ZqlMOafT6WvLf0LMzIh5iC2GQZ5w=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-M52HGYeWOZuyKjWWJvpPTg-1; Sun, 04 Oct 2020 14:33:46 -0400
X-MC-Unique: M52HGYeWOZuyKjWWJvpPTg-1
Received: by mail-qk1-f200.google.com with SMTP id k124so5107543qkc.13
        for <linux-fpga@vger.kernel.org>; Sun, 04 Oct 2020 11:33:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=wt9msYI7XrCVAscXBqWyRdDyyGcbJ8JffuRgtP6fprM=;
        b=Xbc0JjYKZY94Gw+CFPWCl5lAiKsOEbglyOdm9WeyRMSAi+6sIwhbANQWKRNtSTjleU
         n75qj7HEeMZymKpO0oAO3bxL8rlTP4Hs14/Oa2mFemTtxLpZ4pgVvuqYwy7R2jCH81fn
         CyqIx8WiaO2VpU2yLHe3JhHaAsxXy49p+nHV2awy92+6DGoEuxM1koPthILcadPm5/dH
         vV3RMyPNKnaISbeKA+NjSXzkaKo9aCtUhX+M5F9PbmgYreDCAP3Zefrfp1h91qoSidk5
         xJ8AdVPzGr7JzOTigoftniQ+BvmL0uiczwqRHpApOwOCERq3vJrNWdidU111v4yn7EWF
         lZmw==
X-Gm-Message-State: AOAM5330HWla49Tx66csr7eFrYqehlk6aAH5o030uYm6hj79vshEESul
        zWhBXoFHhd/syo/8BIjuVtxAmzl7FQ4HUfZ3CofSXMCg8ZxXrQJxi9eOKtG3T42iPNKqW+gePqo
        SMWlw+vd0pxwipibeFYNgqQ==
X-Received: by 2002:ac8:4998:: with SMTP id f24mr11266953qtq.276.1601836425916;
        Sun, 04 Oct 2020 11:33:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw1NoWkwggkaQEQkuWQWG/uYkcKdHfEXX/cHfTxgg/H6Q/kwK5FxkcMLGVeYSOJ1AogMlmT3Q==
X-Received: by 2002:ac8:4998:: with SMTP id f24mr11266937qtq.276.1601836425762;
        Sun, 04 Oct 2020 11:33:45 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id g14sm5739115qkk.38.2020.10.04.11.33.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Oct 2020 11:33:45 -0700 (PDT)
Subject: Re: [PATCH 09/10] fpga: fpga-mgr: zynqmp: Simplify registration
To:     Moritz Fischer <mdf@kernel.org>, linux-fpga@vger.kernel.org
Cc:     hao.wu@intel.com, michal.simek@xilinx.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        russell.h.weight@intel.com, matthew.gerlach@intel.com
References: <20201004051423.75879-1-mdf@kernel.org>
 <20201004051423.75879-10-mdf@kernel.org>
From:   Tom Rix <trix@redhat.com>
Message-ID: <0a62a6e9-ddfd-e279-7889-a64718ab0ad1@redhat.com>
Date:   Sun, 4 Oct 2020 11:33:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201004051423.75879-10-mdf@kernel.org>
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
>  drivers/fpga/zynqmp-fpga.c | 21 +--------------------
>  1 file changed, 1 insertion(+), 20 deletions(-)

LOTM

Reviewed-by: Tom Rix <trix@redhat.com>


