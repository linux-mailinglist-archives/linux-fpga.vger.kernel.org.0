Return-Path: <linux-fpga+bounces-1295-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89726B1BFE0
	for <lists+linux-fpga@lfdr.de>; Wed,  6 Aug 2025 07:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 484F8624D42
	for <lists+linux-fpga@lfdr.de>; Wed,  6 Aug 2025 05:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B5F17A2FC;
	Wed,  6 Aug 2025 05:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="E/3pPfY9"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31A61114
	for <linux-fpga@vger.kernel.org>; Wed,  6 Aug 2025 05:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754457788; cv=none; b=EKrnxIpbdn6TeSHQOc9AbDN0K8nqwHx3j/T1b4am8redJKGEFlJYS4dYY3y/XxUj5ICq9YiMjNI8jO1v/qZlmJ76Q9qnO5Q+/9ACjnQ7a95NDuXVqdAPdlwAMQunX+eqrMoumU27XggI+jJ6+M+yuKkSbSmqeTJPctJS0NxULEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754457788; c=relaxed/simple;
	bh=6cf9klGAdXzbIARQ1eyhF47+fro7TylyQSD26htR0kE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=ErlPJWb1oxVcHGQ8EZANUu+3o9NeHKnqeCWHctNmVjuS/5SL24fNRUjAhmSYty4qnvtFRRo5rNY2Q1KeLBD2g/9IS8zIXgpZdbzJNbh7yg9q4j7OXJCHNmMNlqKtOm8O5knMeEpupyd+hUXGfX4ZAxZvGPvQ3vCLt3xoTl5xiO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=E/3pPfY9; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250806052258euoutp0233f60e37816376bad9aba225e29fc1c7~ZFg3GQ2GG1579515795euoutp021
	for <linux-fpga@vger.kernel.org>; Wed,  6 Aug 2025 05:22:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250806052258euoutp0233f60e37816376bad9aba225e29fc1c7~ZFg3GQ2GG1579515795euoutp021
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1754457778;
	bh=v2pjvOVdfR7ONGMR/n8vd4uEIkI9RyM22mz7TiyPUnY=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=E/3pPfY9eVbDFWvvwfIhXhatOjfr9v3WdC+8Z7BfO1iDfQb1An6ii0oqRfzw84rMn
	 vjDEUdLdJbsenZB5kjY9hL8xha8zitkhYh4aEkpLcE6+zKHan6P4qIaXhB0X92nKAo
	 W5nIYUFYfNVCVriTIkXAcVoJgGm52xW4je72Xjac=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250806052257eucas1p1e670103b7d1669886b4c4fbc71ebcff4~ZFg2i7p6_2898428984eucas1p1N;
	Wed,  6 Aug 2025 05:22:57 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250806052256eusmtip106a84679e3ae1625fce93984f63b30fd~ZFg1yKxHo1774417744eusmtip1v;
	Wed,  6 Aug 2025 05:22:56 +0000 (GMT)
Message-ID: <6702f672-804e-48f5-af2c-e3c546c91af6@samsung.com>
Date: Wed, 6 Aug 2025 07:22:56 +0200
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: AMD/Xilinx Zynq FPGA manager stopped to work after
 6.16.0-g283564a43383
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: Pavel Pisa <pisa@fel.cvut.cz>, linux-fpga@vger.kernel.org, Michal Simek
	<michal.simek@amd.com>, Jason Gunthorpe <jgg@nvidia.com>, Xu Yilun
	<yilun.xu@intel.com>, Pavel Hronek <hronepa1@fel.cvut.cz>, Jiri Novak
	<jnovak@fel.cvut.cz>, Ondrej Ille <ondrej.ille@gmail.com>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <aJI7juhONZp/8XfI@yilunxu-OptiPlex-7050>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20250806052257eucas1p1e670103b7d1669886b4c4fbc71ebcff4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250804134826eucas1p1350956e17ae463332a69eaa67dc2f8d7
X-EPHeader: CA
X-CMS-RootMailID: 20250804134826eucas1p1350956e17ae463332a69eaa67dc2f8d7
References: <CGME20250804134826eucas1p1350956e17ae463332a69eaa67dc2f8d7@eucas1p1.samsung.com>
	<202508041548.22955.pisa@fel.cvut.cz>
	<a3b997b5-d8b7-4c72-89fc-7d2d21031351@samsung.com>
	<aJI7juhONZp/8XfI@yilunxu-OptiPlex-7050>

On 05.08.2025 19:12, Xu Yilun wrote:
>> Well, my fault. I forgot that dma_map_sgtable() returns only the error
>> code or zero on success, not the number of mapped segments. It looks
>> that the easiest way to fix this issue is to revert my commit
>> 37e00703228a ("zynq_fpga: use sgtable-based scatterlist wrappers"). I'm
> Instead of reverting, can we fix like this?
>
> ---
>
> diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
> index 0be0d569589d..b7629a0e4813 100644
> --- a/drivers/fpga/zynq-fpga.c
> +++ b/drivers/fpga/zynq-fpga.c
> @@ -405,12 +405,12 @@ static int zynq_fpga_ops_write(struct fpga_manager *mgr, struct sg_table *sgt)
>                  }
>          }
>
> -       priv->dma_nelms =
> -           dma_map_sgtable(mgr->dev.parent, sgt, DMA_TO_DEVICE, 0);
> -       if (priv->dma_nelms == 0) {
> +       err = dma_map_sgtable(mgr->dev.parent, sgt, DMA_TO_DEVICE, 0);
> +       if (err) {
>                  dev_err(&mgr->dev, "Unable to DMA map (TO_DEVICE)\n");
> -               return -ENOMEM;
> +               return err;
>          }
> +       priv->dma_nelms = sgt->nents;
>
>          /* enable clock */
>          err = clk_enable(priv->clk);
>
Yes, this is a proper fix for the current code.

Reviewed-by: Marek Szyprowski <m.szyprowski@samsung.com>

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


