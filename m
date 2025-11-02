Return-Path: <linux-fpga+bounces-1401-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 383DBC292AD
	for <lists+linux-fpga@lfdr.de>; Sun, 02 Nov 2025 17:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AE133A4915
	for <lists+linux-fpga@lfdr.de>; Sun,  2 Nov 2025 16:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53EA72264A0;
	Sun,  2 Nov 2025 16:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hgQegk/R"
X-Original-To: linux-fpga@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA6134D3A5;
	Sun,  2 Nov 2025 16:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762101717; cv=none; b=egHOxifyo7T/SoGztT3j6ANta4YjECKZeswprfWpBwLm/4vsOm8z2JBxUOc3HlJuR9Xn4rpqzfT10kh9K/QCgWgjsen9KOBe8tSnRvCPGZPFyoTNDtyhETzWUR7WbcIhZb2cYVW9sOzoBILLBYMR+T75fTGi4CRj9trCe2k30TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762101717; c=relaxed/simple;
	bh=iHF0BEA3Sdyu1viMKhxSBlSf9AbjAIB3BXlZ2+6DsWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AhMRtyoEEKD8gmMiumVNQBI4LmrETD6Kd01m4G7H7S4iUhGQHWm/kJbE0zU6iv6gIrlpvkeezQJB62wuNKT01iN6eequVjbo2m5qERFXsRnZZlQT29o2pnXhdmr/wyWPbzbLyDSb9yQXD3tnsKKEax80tQl50ATpySoiv4LsJGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hgQegk/R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E6E6C4CEF7;
	Sun,  2 Nov 2025 16:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762101717;
	bh=iHF0BEA3Sdyu1viMKhxSBlSf9AbjAIB3BXlZ2+6DsWU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hgQegk/RlbN2WhsB7ADE/PfoOygKZEOtAacO3CjwVXhEfuXIP/DJHY/cz08dIqLsM
	 5e4KGQR2FupcWyuHK9ODpB4LouswcM3RUg2IsAobomfs2C+5HWhCv0+qrAhhTRCJlg
	 7WRdO20efw7uKeWqFfmApue9pJXBd63+5jj6QY4sWY485F6FPIUEo1Pivnk0rWIbBy
	 fXAAvdw6/1O/7W3Lf9Qq7eE7iSnWvhg7a8hW5lYnLDtpTUWMDMbFw6kNcDkWKhSK9C
	 BNoQPjTA+7OcUDfooDP/hSPa61YaB3CuDvmu+/3WGvxjptlhukCV/M1mIa9d708J1b
	 Z1YGlf/htRrCg==
Date: Sun, 2 Nov 2025 17:41:54 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Dinh Nguyen <dinguyen@kernel.org>
Cc: devicetree@vger.kernel.org, linux-fpga@vger.kernel.org, 
	yilun.xu@intel.com, trix@redhat.com, robh+dt@kernel.org, 
	krzysztof.kozlowskii+dt@linaro.org, conor+dt@kernel.org, michal.simek@amd.com
Subject: Re: [PATCH] dt-bindings: fpga: update link for Altera's and AMD
 partial recon
Message-ID: <20251102-ginger-pig-of-lightning-f65ef4@kuoka>
References: <20251101190848.24271-1-dinguyen@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251101190848.24271-1-dinguyen@kernel.org>

On Sat, Nov 01, 2025 at 02:08:48PM -0500, Dinh Nguyen wrote:
> The link is giving the 404 error, so use the correct link for the
> documents
> 
> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> ---
>  Documentation/devicetree/bindings/fpga/fpga-region.yaml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


